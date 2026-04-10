module "vpc" {
  source = "../../modules/vpc"

  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name           = var.cluster_name
  cluster_version        = var.cluster_version
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids
  endpoint_public_access = var.endpoint_public_access
  public_access_cidrs    = var.public_access_cidrs
  cluster_log_types      = var.cluster_log_types
  kms_key_arn            = var.kms_key_arn
  node_groups            = var.node_groups
  tags                   = var.tags
}
