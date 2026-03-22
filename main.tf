# ---------------------------------------------------------------------------
# Root main.tf — calls the VPC module with all required input variables.
# All concrete values are supplied via terraform.tfvars.
# ---------------------------------------------------------------------------
module "vpc" {
  source = "./modules/VPC"

  # Naming / tagging
  project_name = var.project_name
  environment  = var.environment

  # Network addressing
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  # Availability zone placement
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

# ---------------------------------------------------------------------------
# ALB module — internal Application Load Balancer deployed in private subnets.
# VPC outputs are wired directly so no hardcoded IDs are needed here.
# ---------------------------------------------------------------------------
module "alb" {
  source = "./modules/ALB"

  # Naming / tagging
  project_name = var.project_name
  environment  = var.environment

  # Network context from the VPC module
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_cidr           = var.vpc_cidr

  # ALB-specific settings
  alb_name                   = var.alb_name
  target_group_name          = var.target_group_name
  health_check_path          = var.health_check_path
  target_type                = var.target_type
  enable_deletion_protection = var.enable_deletion_protection
}

# ---------------------------------------------------------------------------
# API Gateway module - HTTP API + VPC Link V2 + backend SG.
# Wires directly to VPC and ALB module outputs; no hardcoded IDs.
# ---------------------------------------------------------------------------
module "api_gateway" {
  source = "./modules/API-Gateway"

  # Naming / tagging
  project_name = var.project_name
  environment  = var.environment

  # Network context from the VPC module
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  # ALB context from the ALB module
  alb_dns_name     = module.alb.alb_dns_name
  alb_sg_id        = module.alb.alb_sg_id
  alb_listener_arn = module.alb.http_listener_arn

  # API Gateway-specific settings
  api_gateway_name = var.api_gateway_name
  api_stage_name   = var.api_stage_name
  vpc_link_name    = var.vpc_link_name
}
