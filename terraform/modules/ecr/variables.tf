variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether ECR image tags can be overwritten."
  type        = string

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Whether ECR scans images when they are pushed."
  type        = bool
}

variable "image_retention_count" {
  description = "Number of images to retain in the ECR repository."
  type        = number

  validation {
    condition     = var.image_retention_count > 0
    error_message = "image_retention_count must be greater than zero."
  }
}
