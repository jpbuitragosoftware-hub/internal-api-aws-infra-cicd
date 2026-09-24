data "aws_ssm_parameter" "amazon_linux_2023" {
  # Resolve the current AWS-supported Amazon Linux image without hardcoding an AMI ID.
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

locals {
  # Private placement is the default so the bastion has no public address.
  subnet_id = var.subnet_type == "private" ? var.private_subnet_ids[0] : var.public_subnet_ids[0]
}

resource "aws_iam_role" "this" {
  count              = var.enabled ? 1 : 0
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  # Session Manager replaces SSH and avoids managing bastion key pairs.
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  count = var.enabled ? 1 : 0
  name  = "${var.iam_role_name}-profile"
  role  = aws_iam_role.this[0].name
}

resource "aws_security_group" "this" {
  # The bastion only needs outbound access to SSM and the internal ALB.
  count       = var.enabled ? 1 : 0
  name        = var.security_group_name
  description = "Temporary bastion traffic generator; access through SSM only."
  vpc_id      = var.vpc_id

  egress {
    description = "Allow SSM and internal ALB requests."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  # This instance is intentionally temporary and fully managed by Terraform.
  count                  = var.enabled ? 1 : 0
  ami                    = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type          = var.instance_type
  subnet_id              = local.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.this[0].name
  vpc_security_group_ids = [aws_security_group.this[0].id]
  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    alb_dns_name              = var.alb_dns_name
    traffic_paths              = var.traffic_paths
    traffic_interval_seconds  = var.traffic_interval_seconds
  })

  metadata_options {
    # Require signed instance metadata requests through IMDSv2.
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  depends_on = [aws_iam_role_policy_attachment.ssm]

  tags = {
    Name = var.name
  }
}
