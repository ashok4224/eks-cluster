variable "cluster_name" {
  description = "Name of the EKS cluster (used as prefix for VPC resources)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to deploy subnets into"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (one per AZ)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all VPC resources"
  type        = map(string)
  default     = {}
}
