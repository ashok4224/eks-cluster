terraform {
  backend "s3" {
    # --------------------------------------------------------------------------
    # Replace with your S3 bucket name and DynamoDB table.
    # Run scripts/bootstrap-tfstate.sh to create these resources first.
    # --------------------------------------------------------------------------
    bucket         = "terraform-state-060795934873-dev"
    key            = "eks/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
