variable "name" {
  description = "Name prefix for the temporary bastion resources."
  type        = string
}

variable "enabled" {
  description = "Whether to create the bastion and traffic generator."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID for the bastion."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs available to the bastion."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs available to the bastion."
  type        = list(string)
}

variable "subnet_type" {
  description = "Subnet type for the bastion. Private is recommended; it uses the VPC NAT gateway for SSM."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.subnet_type)
    error_message = "subnet_type must be private or public."
  }
}

variable "alb_dns_name" {
  description = "Internal ALB DNS name used by the traffic generator."
  type        = string
}

variable "traffic_paths" {
  description = "ALB paths selected by the traffic generator."
  type        = list(string)
  default     = ["/health", "/items"]
}

variable "traffic_interval_seconds" {
  description = "Approximate delay between traffic-generator requests."
  type        = number
  default     = 45

  validation {
    condition     = var.traffic_interval_seconds >= 30
    error_message = "traffic_interval_seconds must be at least 30 seconds."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the temporary bastion."
  type        = string
  default     = "t3.micro"
}

variable "iam_role_name" {
  description = "IAM role name for the bastion."
  type        = string
}

variable "security_group_name" {
  description = "Security group name for the bastion."
  type        = string
}
