# ---------------------------------------------------------------
# Production Environment — Variable Values
# HA multi-AZ, larger instances, restricted API access, KMS encryption
# ---------------------------------------------------------------

environment     = "prod"
aws_region      = "ap-south-1"
cluster_name    = "eks-prod"
cluster_version = "1.30"

# VPC
vpc_cidr             = "10.30.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
private_subnet_cidrs = ["10.30.10.0/24", "10.30.11.0/24", "10.30.12.0/24"]

# EKS API access — restrict to corporate/VPN CIDR in production
# Replace 198.51.100.0/24 with your actual CIDR(s)
endpoint_public_access = true
public_access_cidrs    = ["198.51.100.0/24"]

# KMS key for secrets encryption — replace with your key ARN
# kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/your-key-id"
kms_key_arn = ""

# Node Groups
node_groups = {
  general = {
    instance_types = ["m5.xlarge"]
    capacity_type  = "ON_DEMAND"
    min_size       = 3
    max_size       = 10
    desired_size   = 3
    labels         = { role = "general", env = "prod" }
    taints         = []
  }
  spot = {
    instance_types = ["m5.xlarge", "m5a.xlarge", "m4.xlarge"]
    capacity_type  = "SPOT"
    min_size       = 0
    max_size       = 10
    desired_size   = 0
    labels         = { role = "spot", env = "prod" }
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
