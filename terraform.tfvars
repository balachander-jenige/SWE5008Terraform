# ---------------------------------------------------------------------------
# terraform.tfvars — concrete values for all input variables.
# Adjust these to match your target AWS account and naming conventions.
# ---------------------------------------------------------------------------

# AWS region where all resources will be provisioned
aws_region = "ap-southeast-1"

# Project name — used as a prefix in every resource Name tag
project_name = "TraceDataAI"

# Deployment environment
environment = "uat"

# VPC CIDR — the overall address space for the VPC
vpc_cidr = "11.0.0.0/16"

# Public subnets — one per availability zone
public_subnet_1_cidr = "11.0.1.0/24"
public_subnet_2_cidr = "11.0.2.0/24"

# Private subnets — one per availability zone
private_subnet_1_cidr = "11.0.3.0/24"
private_subnet_2_cidr = "11.0.4.0/24"

# Availability zones — must belong to the selected aws_region
availability_zone_1 = "ap-south-1a"
availability_zone_2 = "ap-south-1b"

# ---------------------------------------------------------------------------
# ALB settings
# ---------------------------------------------------------------------------

# ALB name — max 32 characters
alb_name = "tracedataai-uat-alb"

# Target group name — max 32 characters
target_group_name = "tracedataai-uat-tg"

# Health check path exposed by the backend service
health_check_path = "/"

# "ip" for ECS/Fargate targets, "instance" for EC2 targets
target_type = "instance"

# Set to true in prod to prevent accidental ALB deletion
enable_deletion_protection = false

# ---------------------------------------------------------------------------
# API Gateway settings
# ---------------------------------------------------------------------------

# Name for the HTTP API
api_gateway_name = "tracedataai-uat-api"

# Deployment stage name
api_stage_name = "uat"

# Name for the VPC Link V2
vpc_link_name = "tracedataai-uat-vpc-link"

# ---------------------------------------------------------------------------
# ECS on EC2 settings
# ---------------------------------------------------------------------------

# EC2 instance type for ECS container hosts (Intel x86_64 required for c7i-flex)
ecs_instance_type = "c7i-flex.large"

# Auto Scaling Group sizing
ecs_min_instances     = 1
ecs_max_instances     = 3
ecs_desired_instances = 1

# Number of ECS task replicas the service should keep running
service_replica_count = 1

# Container name (must match the name field in the task definition)
container_name = "tracedata-frontend-container"

# Full ECR image URI — update the tag on each deployment
container_image = "704048935372.dkr.ecr.ap-southeast-1.amazonaws.com/tracedataaifrontend:latest"

# Port the Next.js app listens on inside the container
container_port = 3000

# Task-level resource ceilings (hard limits enforced by ECS on the whole task)
task_cpu    = "1024"
task_memory = "2048"

# Container-level resource limits
container_cpu                = 1024  # CPU units reserved by this container
container_memory             = 2048  # hard limit — OOM kill if exceeded
container_memory_reservation = 1024  # soft limit used for scheduling

# Next.js runtime environment variables
node_env     = "production"
node_options = "--max-old-space-size=1536"

# CloudWatch log retention in days
log_retention_days = 7
