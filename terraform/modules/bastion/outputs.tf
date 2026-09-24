output "instance_id" {
  description = "ID of the temporary bastion instance."
  value       = try(aws_instance.this[0].id, null)
}

output "security_group_id" {
  description = "Security group ID of the temporary bastion."
  value       = try(aws_security_group.this[0].id, null)
}

output "iam_role_arn" {
  description = "IAM role ARN used by the bastion."
  value       = try(aws_iam_role.this[0].arn, null)
}
