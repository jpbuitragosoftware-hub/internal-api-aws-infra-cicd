variable "repository_subject" {
  description = "Exact GitHub OIDC subject allowed to assume the role."
  type        = string
}

variable "role_name" {
  description = "IAM role name for GitHub Actions."
  type        = string
}

variable "ecr_repository_arn" {
  description = "ECR repository ARN."
  type        = string
}

variable "ecs_service_arn" {
  description = "ECS service ARN."
  type        = string
}

variable "task_execution_role_arn" {
  description = "ECS task execution role ARN."
  type        = string
}
