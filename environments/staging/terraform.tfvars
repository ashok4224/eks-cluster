# ---------------------------------------------------------------
# Staging Environment — Variable Values
# Multi-AZ, mixed ON_DEMAND + SPOT, mirrors prod topology
# ---------------------------------------------------------------

environment     = "staging"
aws_region      = "ap-south-1"
cluster_name    = "eks-staging"
cluster_version = "1.30"

# VPC
vpc_cidr             = "10.20.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
private_subnet_cidrs = ["10.20.10.0/24", "10.20.11.0/24", "10.20.12.0/24"]

# EKS API access
endpoint_public_access = true
public_access_cidrs    = ["0.0.0.0/0"]

# No KMS for staging (add ARN to enable)
kms_key_arn = ""

# Node Groups
node_groups = {
  general = {
    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
    min_size       = 2
    max_size       = 5
    desired_size   = 2
    labels         = { role = "general", env = "staging" }
    taints         = []
  }
  spot = {
    instance_types = ["t3.large", "t3a.large", "t2.large"]
    capacity_type  = "SPOT"
    min_size       = 0
    max_size       = 5
    desired_size   = 0
    labels         = { role = "spot", env = "staging" }
    taints = [{
      key    = "spot"
      value  = "true"
      effect = "NO_SCHEDULE"
    }]
  }
}

tags = {
  Team       = "platform"
  CostCenter = "engineering"
}
