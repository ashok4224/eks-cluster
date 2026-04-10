terraform {
  backend "s3" {
    bucket         = "terraform-state-060795934873-dev"
    key            = "eks/staging/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
