terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_block    = var.public_subnet_cidr_block
  public_route_cidr_block     = var.public_route_cidr_block
  availability_zone           = var.availability_zone
  private_subnet_a_cidr_block = var.private_subnet_a_cidr_block
  private_subnet_b_cidr_block = var.private_subnet_b_cidr_block
  private_availability_zone_a = var.private_availability_zone_a
  private_availability_zone_b = var.private_availability_zone_b
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

module "rds" {
  source = "./modules/rds"

  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  ecs_security_group_id   = module.ecs.security_group_id
  identifier              = var.rds_identifier
  database_name           = var.rds_database_name
  master_username         = var.rds_master_username
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  backup_retention_period = var.rds_backup_retention_period
  deletion_protection     = var.rds_deletion_protection
  skip_final_snapshot     = var.rds_skip_final_snapshot
  secret_name             = var.rds_secret_name
}

module "ecs_app" {
  source = "./modules/ecs_app"

  cluster_name            = module.ecs.cluster_name
  task_execution_role_arn = module.ecs.execution_role_arn
  security_group_id       = module.ecs.security_group_id
  subnet_id               = module.vpc.public_subnet_id
  image_repository_url    = module.ecr.repository_url
  image_tag               = var.ecs_image_tag
  task_family             = var.ecs_task_family
  container_name          = var.ecs_container_name
  container_port          = var.ecs_container_port
  task_cpu                = var.ecs_task_cpu
  task_memory             = var.ecs_task_memory
  log_group_name          = module.ecs.log_group_name
  database_host           = module.rds.endpoint
  database_secret_arn     = module.rds.secret_arn
  service_name            = var.ecs_service_name
  desired_count           = var.ecs_desired_count
  allowed_ingress_cidr    = var.ecs_allowed_ingress_cidr
}

module "github_oidc" {
  source = "./modules/github_oidc"

  repository            = var.github_repository
  branch                = var.github_deployment_branch
  role_name             = var.github_actions_role_name
  ecr_repository_arn    = module.ecr.repository_arn
  ecs_cluster_arn       = module.ecs.cluster_arn
  ecs_service_arn       = module.ecs_app.service_arn
  task_execution_role_arn = module.ecs.execution_role_arn
}
