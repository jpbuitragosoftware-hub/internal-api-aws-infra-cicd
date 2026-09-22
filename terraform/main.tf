terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_route_cidr_block  = var.public_route_cidr_block
  availability_zone        = var.availability_zone
}

module "ecr" {
  source = "./modules/ecr"

  repository_name       = var.ecr_repository_name
  image_tag_mutability  = var.ecr_image_tag_mutability
  scan_on_push          = var.ecr_scan_on_push
  image_retention_count = var.ecr_image_retention_count
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id                     = module.vpc.vpc_id
  cluster_name               = var.ecs_cluster_name
  execution_role_name        = var.ecs_execution_role_name
  log_group_name             = var.ecs_log_group_name
  log_retention_in_days      = var.ecs_log_retention_in_days
  security_group_name        = var.ecs_security_group_name
  security_group_description = var.ecs_security_group_description
}
