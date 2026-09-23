resource "aws_grafana_workspace" "this" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  data_sources             = ["CLOUDWATCH"]
  name                     = var.name
  permission_type          = "SERVICE_MANAGED"
}
