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

variable "private_subnet_a_cidr_block" {
  description = "CIDR block for the first private subnet."
  type        = string
}

variable "private_subnet_b_cidr_block" {
  description = "CIDR block for the second private subnet."
  type        = string
}

variable "private_availability_zone_a" {
  description = "Availability Zone for the first private subnet."
  type        = string
}

variable "private_availability_zone_b" {
  description = "Availability Zone for the second private subnet."
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

variable "rds_identifier" {
  description = "Identifier of the RDS instance."
  type        = string
}

variable "rds_database_name" {
  description = "Initial database name."
  type        = string
}

variable "rds_master_username" {
  description = "Master username for the database."
  type        = string
}

variable "rds_engine_version" {
  description = "PostgreSQL engine version."
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in GiB."
  type        = number
}

variable "rds_backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
}

variable "rds_deletion_protection" {
  description = "Whether deletion protection is enabled."
  type        = bool
}

variable "rds_skip_final_snapshot" {
  description = "Whether to skip the final snapshot on deletion."
  type        = bool
}

variable "rds_secret_name" {
  description = "Name of the Secrets Manager secret for database credentials."
  type        = string
}

variable "ecs_task_family" {
  description = "Family name of the ECS task definition."
  type        = string
}

variable "ecs_container_name" {
  description = "Name of the ECS container."
  type        = string
}

variable "ecs_container_port" {
  description = "Port exposed by the application container."
  type        = number
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
  description = "ECR image tag used by the ECS task."
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service."
  type        = string
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks desired by the service."
  type        = number
}

variable "ecs_allowed_ingress_cidr" {
  description = "CIDR allowed to access the application port."
  type        = string
}