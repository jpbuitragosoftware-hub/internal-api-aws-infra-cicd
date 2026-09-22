variable "name" {
  description = "Name prefix for monitoring resources."
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name."
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name."
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix used by CloudWatch dimensions."
  type        = string
}

variable "target_group_arn_suffix" {
  description = "Target group ARN suffix used by CloudWatch dimensions."
  type        = string
}

variable "rds_identifier" {
  description = "RDS instance identifier."
  type        = string
}

variable "notification_email" {
  description = "Email address for SNS alarm notifications."
  type        = string
}
