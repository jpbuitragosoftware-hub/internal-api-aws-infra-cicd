output "workspace_id" {
  description = "Amazon Managed Grafana workspace ID."
  value       = aws_grafana_workspace.this.id
}

output "endpoint" {
  description = "Amazon Managed Grafana workspace endpoint."
  value       = aws_grafana_workspace.this.endpoint
}
