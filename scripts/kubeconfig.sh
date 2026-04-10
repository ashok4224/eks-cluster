#!/usr/bin/env bash
# kubeconfig.sh
# Updates ~/.kube/config for one or all EKS environments.
#
# Usage:
#   chmod +x scripts/kubeconfig.sh
#   ./scripts/kubeconfig.sh              # update all environments
#   ./scripts/kubeconfig.sh dev          # update only dev
#   ./scripts/kubeconfig.sh staging
#   ./scripts/kubeconfig.sh prod

set -euo pipefail

AWS_REGION="${AWS_REGION:-us-east-1}"

ENVS=("dev" "staging" "prod")
CLUSTER_NAMES=(
  "eks-dev"
  "eks-staging"
  "eks-prod"
)

update_kubeconfig() {
  local name="$1"
  echo "==> Updating kubeconfig for cluster: ${name}"
  aws eks update-kubeconfig \
    --region "$AWS_REGION" \
    --name "$name" \
    --alias "$name"
  echo "    Context '${name}' added/updated."
}

TARGET="${1:-all}"

if [[ "$TARGET" == "all" ]]; then
  for name in "${CLUSTER_NAMES[@]}"; do
    update_kubeconfig "$name" || echo "    WARNING: cluster '${name}' not found — skipping."
  done
else
  # Map env name → cluster name
  case "$TARGET" in
    dev)     update_kubeconfig "eks-dev" ;;
    staging) update_kubeconfig "eks-staging" ;;
    prod)    update_kubeconfig "eks-prod" ;;
    *)
      echo "Unknown environment: ${TARGET}"
      echo "Valid values: dev | staging | prod | all"
      exit 1
      ;;
  esac
fi

echo ""
echo "==> Available contexts:"
kubectl config get-contexts
