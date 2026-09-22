variable "vpc_id" {
  description = "ID of the VPC for the ECS security group."
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "execution_role_name" {
  description = "Name of the ECS task execution IAM role."
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group."
  type        = string
}

variable "log_retention_in_days" {
  description = "Number of days to retain logs."
  type        = number
}

variable "security_group_name" {
  description = "Name of the security group."
  type        = string
}

variable "security_group_description" {
  description = "Description of the ECS security group."
  type        = string
}

variable "task_family" {
  description = "Family name of the ECS task definition."
  type        = string
}

variable "container_name" {
  description = "Name of the container."
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
}

variable "task_cpu" {
  description = "CPU units allocated to the Fargate task."
  type        = number
}

variable "task_memory" {
  description = "Memory in MiB allocated to the Fargate task."
  type        = number
}

variable "image_tag" {
  description = "ECR image tag used by the task definition."
  type        = string
}

variable "image_repository_url" {
  description = "URL of the ECR repository."
  type        = string
}
