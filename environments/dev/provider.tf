terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = "terraform-${var.environment}"
  }

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "eks-cluster"
      ManagedBy   = "terraform"
    }
  }
}
