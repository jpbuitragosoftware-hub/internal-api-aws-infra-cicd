variable "name" {
  description = "Name of the Amazon Managed Grafana workspace."
  type        = string
}

variable "workspace_role_name" {
  description = "IAM role name used by Amazon Managed Grafana."
  type        = string
}
