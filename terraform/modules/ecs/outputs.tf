output "cluster_id" {
  description = "ID of the ECS cluster."
  value       = aws_ecs_cluster.this.id
}

output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = aws_ecs_cluster.this.name
}

output "execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = aws_iam_role.task_execution.arn
}

output "log_group_name" {
  description = "Name of the ECS CloudWatch log group."
  value       = aws_cloudwatch_log_group.this.name
}

output "security_group_id" {
  description = "ID of the ECS security group."
  value       = aws_security_group.this.id
}
