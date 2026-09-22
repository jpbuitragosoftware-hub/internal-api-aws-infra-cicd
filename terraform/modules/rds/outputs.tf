output "endpoint" {
  description = "RDS endpoint hostname."
  value       = aws_db_instance.this.address
}

output "port" {
  description = "RDS endpoint port."
  value       = aws_db_instance.this.port
}

output "secret_arn" {
  description = "ARN of the database credentials secret."
  value       = aws_secretsmanager_secret.database.arn
}

output "security_group_id" {
  description = "ID of the RDS security group."
  value       = aws_security_group.this.id
}
