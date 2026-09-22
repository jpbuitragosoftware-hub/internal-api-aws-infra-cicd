variable "cluster_name" {
  description = "ECS cluster name."
  type        = string
}

variable "task_execution_role_arn" {
  description = "ECS task execution role ARN."
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the ECS task."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks."
  type        = list(string)
}

variable "image_repository_url" {
  description = "ECR repository URL."
  type        = string
}

variable "image_tag" {
  description = "ECR image tag."
  type        = string
}

variable "task_family" {
  description = "ECS task definition family."
  type        = string
}

variable "container_name" {
  description = "Container name."
  type        = string
}

variable "container_port" {
  description = "Container port."
  type        = number
}

variable "task_cpu" {
  description = "Fargate CPU units."
  type        = number
}

variable "task_memory" {
  description = "Fargate memory in MiB."
  type        = number
}

variable "log_group_name" {
  description = "CloudWatch log group name."
  type        = string
}

variable "database_host" {
  description = "RDS endpoint hostname."
  type        = string
}

variable "database_secret_arn" {
  description = "Database credentials secret ARN."
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for the ECS service."
  type        = string
}

variable "service_name" {
  description = "ECS service name."
  type        = string
}

variable "desired_count" {
  description = "Desired number of running tasks."
  type        = number
}

variable "load_balancer_security_group_id" {
  description = "Security group ID of the internal load balancer."
  type        = string
}
