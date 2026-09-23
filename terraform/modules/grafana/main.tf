data "aws_iam_policy_document" "workspace_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["grafana.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "workspace" {
  name               = var.workspace_role_name
  assume_role_policy = data.aws_iam_policy_document.workspace_assume_role.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.workspace.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonGrafanaCloudWatchAccess"
}

resource "aws_grafana_workspace" "this" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  data_sources             = ["CLOUDWATCH"]
  name                     = var.name
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = aws_iam_role.workspace.arn
}
