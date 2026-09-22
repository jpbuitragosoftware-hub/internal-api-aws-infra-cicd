variable "vpc_id" {
  description = "ID of the VPC."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID allowed to connect to PostgreSQL."
  type        = string
}

variable "identifier" {
  description = "RDS instance identifier."
  type        = string
}

variable "database_name" {
  description = "Initial database name."
  type        = string
}

variable "master_username" {
  description = "Master database username."
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GiB."
  type        = number
}

variable "backup_retention_period" {
  description = "Automated backup retention in days."
  type        = number
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled."
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot on deletion."
  type        = bool
}

variable "secret_name" {
  description = "Secrets Manager secret name."
  type        = string
}
