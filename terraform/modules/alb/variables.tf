variable "name" {
  description = "Name of the internal application load balancer."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the load balancer."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for the load balancer."
  type        = list(string)
}

variable "container_port" {
  description = "Application port exposed by ECS."
  type        = number
}

variable "allowed_ingress_cidr" {
  description = "CIDR allowed to access the internal load balancer."
  type        = string
}
