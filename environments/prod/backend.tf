terraform {
  backend "s3" {
    bucket         = "REPLACE_ME_terraform-state-bucket"
    key            = "eks/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
