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
