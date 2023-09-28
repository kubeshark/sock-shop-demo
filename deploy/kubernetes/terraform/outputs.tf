output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Cluster name"
  value       = local.name
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks update-kubeconfig --name ${local.name} --kubeconfig <config_file>"
}
