data "aws_iam_policy_document" "task_execution_assume_role" {
  # ECS assumes this role to pull images and publish container logs.
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "task_execution" {
  name               = var.execution_role_name
  assume_role_policy = data.aws_iam_policy_document.task_execution_assume_role.json
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days
}

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "aws_security_group" "this" {
  # Tasks do not accept unsolicited inbound traffic from the internet.
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  egress {
    description = "Allow outbound traffic."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
