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
  description = "Description of the security group."
  type        = string
}
