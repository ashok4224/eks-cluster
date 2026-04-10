output "cluster_id" {
  description = "ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "HTTPS endpoint of the EKS API server"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  description = "Kubernetes version running on the cluster"
  value       = aws_eks_cluster.main.version
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate authority data for the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL — used to create IRSA IAM roles"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider for the cluster"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "cluster_role_arn" {
  description = "ARN of the IAM role used by the EKS control plane"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_group_role_arn" {
  description = "ARN of the IAM role used by EKS worker nodes"
  value       = aws_iam_role.eks_node_group.arn
}

output "cluster_security_group_id" {
  description = "Additional security group ID attached to the EKS cluster"
  value       = aws_security_group.eks_cluster.id
}
