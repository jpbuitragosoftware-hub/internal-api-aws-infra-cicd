variable "aws_region" {
  description = "AWS region where the infrastructure is deployed."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the first public subnet."
  type        = string
}

variable "public_subnet_b_cidr_block" {
  description = "CIDR block for the second public subnet."
  type        = string
}

variable "public_route_cidr_block" {
  description = "Destination CIDR block for the public route."
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the first public subnet."
  type        = string
}

variable "public_availability_zone_b" {
  description = "Availability Zone for the second public subnet."
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
  description = "Lab setting: number of days to retain automated backups."
  type        = number
}

variable "rds_deletion_protection" {
  description = "Lab setting: whether deletion protection is enabled."
  type        = bool
}

variable "rds_skip_final_snapshot" {
  description = "Lab setting: whether to skip the final snapshot on deletion."
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

variable "alb_name" {
  description = "Name of the internal application load balancer."
  type        = string
}

variable "monitoring_notification_email" {
  description = "Email address for CloudWatch alarm notifications."
  type        = string
}

variable "grafana_workspace_name" {
  description = "Name of the Amazon Managed Grafana workspace."
  type        = string
}

variable "grafana_workspace_role_name" {
  description = "IAM role name used by Amazon Managed Grafana."
  type        = string
}

variable "github_repository_subject" {
  description = "Exact GitHub OIDC subject allowed to deploy."
  type        = string
}

variable "github_actions_role_name" {
  description = "IAM role assumed by GitHub Actions."
  type        = string
}

variable "bastion_enabled" {
  description = "Whether to create the temporary SSM bastion and traffic generator."
  type        = bool
  default     = false
}

variable "bastion_name" {
  description = "Name of the temporary bastion instance."
  type        = string
  default     = "internal-api-bastion"
}

variable "bastion_subnet_type" {
  description = "Subnet type for the bastion; private is recommended."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.bastion_subnet_type)
    error_message = "bastion_subnet_type must be private or public."
  }
}

variable "bastion_traffic_paths" {
  description = "Internal ALB paths used by the bastion traffic generator."
  type        = list(string)
  default     = ["/health", "/items"]
}

variable "bastion_traffic_interval_seconds" {
  description = "Approximate delay between bastion traffic-generator requests."
  type        = number
  default     = 45
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the temporary bastion."
  type        = string
  default     = "t3.micro"
}

variable "bastion_iam_role_name" {
  description = "IAM role name for the temporary bastion."
  type        = string
  default     = "internal-api-bastion"
}

variable "bastion_security_group_name" {
  description = "Security group name for the temporary bastion."
  type        = string
  default     = "internal-api-bastion"
}