output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = module.vpc.public_subnet_id
}

output "alb_dns_name" {
  description = "Internal application load balancer DNS name."
  value       = module.alb.dns_name
}

output "ecr_repository_name" {
  description = "Name of the ECR repository."
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  value       = module.ecs.cluster_name
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = module.ecs.execution_role_arn
}

output "ecs_log_group_name" {
  description = "Name of the ECS CloudWatch log group."
  value       = module.ecs.log_group_name
}

output "ecs_security_group_id" {
  description = "ID of the ECS security group."
  value       = module.ecs.security_group_id
}

output "rds_endpoint" {
  description = "RDS endpoint hostname."
  value       = module.rds.endpoint
}

output "rds_secret_arn" {
  description = "ARN of the database credentials secret."
  value       = module.rds.secret_arn
}

output "github_actions_role_arn" {
  description = "IAM role ARN for GitHub Actions OIDC."
  value       = module.github_oidc.role_arn
}

output "monitoring_sns_topic_arn" {
  description = "SNS topic ARN for CloudWatch alarm notifications."
  value       = module.monitoring.sns_topic_arn
}

output "cloudwatch_dashboard_name" {
  description = "CloudWatch dashboard name."
  value       = module.monitoring.dashboard_name
}

output "grafana_workspace_id" {
  description = "Amazon Managed Grafana workspace ID."
  value       = module.grafana.workspace_id
}

output "grafana_endpoint" {
  description = "Amazon Managed Grafana workspace endpoint."
  value       = module.grafana.endpoint
}
