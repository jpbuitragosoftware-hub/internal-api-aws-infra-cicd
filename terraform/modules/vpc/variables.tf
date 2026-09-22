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
