variable "aws_region" {
  description = "AWS region where the infrastructure is deployed."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "public_route_cidr_block" {
  description = "Destination CIDR block for the public route."
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet."
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "Whether ECR image tags can be overwritten."
  type        = string

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.ecr_image_tag_mutability)
    error_message = "ecr_image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "ecr_scan_on_push" {
  description = "Whether ECR scans images when they are pushed."
  type        = bool
}

variable "ecr_image_retention_count" {
  description = "Number of images to retain in the ECR repository."
  type        = number

  validation {
    condition     = var.ecr_image_retention_count > 0
    error_message = "ecr_image_retention_count must be greater than zero."
  }
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "ecs_execution_role_name" {
  description = "Name of the ECS task execution IAM role."
  type        = string
}

variable "ecs_log_group_name" {
  description = "Name of the CloudWatch log group for ECS."
  type        = string
}

variable "ecs_log_retention_in_days" {
  description = "Number of days to retain ECS logs."
  type        = number

  validation {
    condition     = var.ecs_log_retention_in_days > 0
    error_message = "ecs_log_retention_in_days must be greater than zero."
  }
}

variable "ecs_security_group_name" {
  description = "Name of the ECS security group."
  type        = string
}

variable "ecs_security_group_description" {
  description = "Description of the ECS security group."
  type        = string
}

variable "ecs_task_family" {
  description = "Family name of the ECS task definition."
  type        = string
}

variable "ecs_container_name" {
  description = "Name of the container in the ECS task definition."
  type        = string
}

variable "ecs_container_port" {
  description = "Port exposed by the application container."
  type        = number

  validation {
    condition     = var.ecs_container_port > 0 && var.ecs_container_port < 65536
    error_message = "ecs_container_port must be between 1 and 65535."
  }
}

variable "ecs_task_cpu" {
  description = "CPU units allocated to the Fargate task."
  type        = number
}

variable "ecs_task_memory" {
  description = "Memory in MiB allocated to the Fargate task."
  type        = number
}

variable "ecs_image_tag" {
  description = "ECR image tag used by the ECS task definition."
  type        = string
}