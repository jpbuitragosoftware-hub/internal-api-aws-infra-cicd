output "dns_name" {
  description = "Internal load balancer DNS name."
  value       = aws_lb.this.dns_name
}

output "security_group_id" {
  description = "Load balancer security group ID."
  value       = aws_security_group.this.id
}

output "target_group_arn" {
  description = "Target group ARN."
  value       = aws_lb_target_group.this.arn
}

output "arn_suffix" {
  description = "Load balancer ARN suffix for CloudWatch metrics."
  value       = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  description = "Target group ARN suffix for CloudWatch metrics."
  value       = aws_lb_target_group.this.arn_suffix
}
