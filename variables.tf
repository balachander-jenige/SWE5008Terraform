variable "aws_region" {
  type        = string
  description = "AWS region in which to create all resources (e.g. us-east-1)"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name used as a prefix in resource Name tags"
  default     = "myapp"
}

variable "environment" {
  type        = string
  description = "Deployment environment — one of: dev, staging, prod"
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1 (must fall within vpc_cidr)"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2 (must fall within vpc_cidr)"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private subnet 1 (must fall within vpc_cidr)"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private subnet 2 (must fall within vpc_cidr)"
  default     = "10.0.4.0/24"
}

variable "availability_zone_1" {
  type        = string
  description = "First availability zone for subnet placement (e.g. us-east-1a)"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  type        = string
  description = "Second availability zone for subnet placement (e.g. us-east-1b)"
  default     = "us-east-1b"
}

# ---------------------------------------------------------------------------
# ALB variables
# ---------------------------------------------------------------------------

variable "alb_name" {
  type        = string
  description = "Name of the internal Application Load Balancer (max 32 characters)"
  default     = "internal-alb"
}

variable "target_group_name" {
  type        = string
  description = "Name of the ALB target group (max 32 characters)"
  default     = "app-tg"
}

variable "health_check_path" {
  type        = string
  description = "HTTP path the ALB uses for target health checks"
  default     = "/health"
}

variable "target_type" {
  type        = string
  description = "Target group target type: \"ip\" (ECS/Fargate) or \"instance\" (EC2)"
  default     = "ip"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Prevent accidental deletion of the ALB (set to true for prod)"
  default     = false
}

# ---------------------------------------------------------------------------
# API Gateway variables
# ---------------------------------------------------------------------------

variable "api_gateway_name" {
  type        = string
  description = "Name for the API Gateway HTTP API"
  default     = "myapp-api"
}

variable "api_stage_name" {
  type        = string
  description = "Deployment stage name (e.g. dev, staging, prod)"
  default     = "dev"
}

variable "vpc_link_name" {
  type        = string
  description = "Name for the VPC Link V2 resource"
  default     = "myapp-vpc-link"
}
