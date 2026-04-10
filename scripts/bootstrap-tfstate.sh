#!/usr/bin/env bash
# bootstrap-tfstate.sh
# Creates the S3 bucket and DynamoDB table needed for Terraform remote state.
# Run this ONCE before running terraform init in any environment.
#
# Usage:
#   chmod +x scripts/bootstrap-tfstate.sh
#   ./scripts/bootstrap-tfstate.sh <bucket-name> <aws-region>

set -euo pipefail

BUCKET_NAME="${1:-}"
AWS_REGION="${2:-us-east-1}"
DYNAMODB_TABLE="terraform-state-lock"

if [[ -z "$BUCKET_NAME" ]]; then
  echo "Usage: $0 <bucket-name> [aws-region]"
  exit 1
fi

echo "==> Creating S3 bucket: ${BUCKET_NAME} in ${AWS_REGION}"

if [[ "$AWS_REGION" == "us-east-1" ]]; then
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION"
else
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION" \
    --create-bucket-configuration LocationConstraint="$AWS_REGION"
fi

echo "==> Enabling versioning on: ${BUCKET_NAME}"
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled

echo "==> Enabling default SSE (AES-256) on: ${BUCKET_NAME}"
aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'

echo "==> Blocking public access on: ${BUCKET_NAME}"
aws s3api put-public-access-block \
  --bucket "$BUCKET_NAME" \
  --public-access-block-configuration \
    "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

echo "==> Creating DynamoDB table: ${DYNAMODB_TABLE}"
aws dynamodb create-table \
  --table-name "$DYNAMODB_TABLE" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region "$AWS_REGION" || echo "Table may already exist — skipping."

echo ""
echo "==> Bootstrap complete."
echo ""
echo "Next step: replace 'REPLACE_ME_terraform-state-bucket' in each"
echo "environments/*/backend.tf with: ${BUCKET_NAME}"
echo ""
echo "Then run in each environment directory:"
echo "  terraform init"
