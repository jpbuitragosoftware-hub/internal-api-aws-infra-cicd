resource "aws_security_group" "this" {
  # Limit access to HTTP requests originating inside the VPC.
  name        = "${var.name}-alb"
  description = "Security group for the internal application load balancer."
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP access from the internal VPC."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ingress_cidr]
  }

  egress {
    description = "Allow traffic to ECS targets."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "this" {
  # Keep the load balancer private because the API is internal.
  name               = var.name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "this" {
  # ECS tasks register directly by IP when using awsvpc networking.
  name        = "${var.name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    # Reuse the application's database-aware health endpoint.
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "this" {
  # Forward internal HTTP traffic to the ECS target group.
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
