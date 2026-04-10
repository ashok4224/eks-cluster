# ---------------------------------------------------------------
# Dev Environment — Variable Values
# Small footprint, ON_DEMAND only, open API access
# ---------------------------------------------------------------

environment     = "dev"
assume_role_arn = "arn:aws:iam::060795934873:role/TerraformRole"
aws_region      = "ap-south-1"
cluster_name    = "eks-dev"
cluster_version = "1.30"

# VPC
vpc_cidr             = "10.10.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]

# EKS API access
endpoint_public_access = true
public_access_cidrs    = ["0.0.0.0/0"]

# No KMS encryption for dev (cost savings)
kms_key_arn = ""

# Node Groups
node_groups = {
  general = {
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    min_size       = 1
    max_size       = 3
    desired_size   = 1
    labels         = { role = "general", env = "dev" }
    taints         = []
  }
}

tags = {
  Team       = "platform"
  CostCenter = "engineering"
}
