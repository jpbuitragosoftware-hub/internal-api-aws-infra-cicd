data "aws_region" "current" {}

resource "aws_iam_role_policy" "database_secret_access" {
  name = "${var.task_family}-database-secret"
  role = element(split("/", var.task_execution_role_arn), length(split("/", var.task_execution_role_arn)) - 1)

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = var.database_secret_arn
      }
    ]
  })
}

resource "aws_vpc_security_group_ingress_rule" "load_balancer" {
  security_group_id = var.security_group_id
  referenced_security_group_id = var.load_balancer_security_group_id
  from_port         = var.container_port
  to_port           = var.container_port
  ip_protocol       = "tcp"
  description       = "Application traffic from the internal load balancer."
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.image_repository_url}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "DB_HOST", value = var.database_host },
        { name = "DB_PORT", value = "5432" },
        { name = "PORT", value = tostring(var.container_port) }
      ]

      secrets = [
        { name = "DB_NAME", valueFrom = "${var.database_secret_arn}:dbname::" },
        { name = "DB_USER", valueFrom = "${var.database_secret_arn}:username::" },
        { name = "DB_PASSWORD", valueFrom = "${var.database_secret_arn}:password::" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name             = var.service_name
  cluster          = var.cluster_name
  task_definition  = aws_ecs_task_definition.this.arn
  desired_count    = var.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
}
