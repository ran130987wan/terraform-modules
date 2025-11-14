##############################################################################
# Azure Kubernetes Service (AKS) Module - Outputs
#
# These outputs expose key attributes of the created AKS cluster including
# connection details, identities, and network information for use by other
# modules or for kubectl/helm configuration.
##############################################################################

# Cluster identification
output "id" {
  description = "The ID of the cluster"
  value       = azurerm_kubernetes_cluster.k8s.id
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = azurerm_kubernetes_cluster.k8s.name
}

# Kubernetes authentication credentials (sensitive)
output "client_key" {
  description = "Base64 encoded client key for cluster authentication"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
}

output "client_certificate" {
  description = "Base64 encoded client certificate for cluster authentication"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
}

output "cluster_ca_certificate" {
  description = "Base64 encoded cluster CA certificate for validating API server"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
}

output "cluster_username" {
  description = "Username for basic authentication (if enabled)"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.k8s.kube_config[0].username
}

output "kube_config" {
  description = "Raw kubeconfig file content for cluster access"
  value       = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "Kubernetes API server endpoint URL"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.k8s.kube_config[0].host
}

# Resource group information
output "node_resource_group" {
  description = "Auto-created resource group containing AKS cluster infrastructure"
  value       = azurerm_kubernetes_cluster.k8s.node_resource_group
}

# Network information
output "effective_outbound_ips" {
  description = "Effective outbound IP addresses used by the cluster load balancer"
  value       = azurerm_kubernetes_cluster.k8s.network_profile[0].load_balancer_profile[0].effective_outbound_ips
}

output "fqdn" {
  description = "The fully qualified domain name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.k8s.fqdn
}

# Managed identity information
output "aks_managed_identity" {
  description = "The object ID of the AKS managed identity"
  value       = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}

output "aks_kubelet_identity_client_id" {
  description = "The client ID of the AKS kubelet identity"
  value       = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].client_id
}

output "aks_managed_identity_id" {
  description = "The user-assigned identity resource ID used by kubelet"
  value       = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].user_assigned_identity_id
}

output "tenant_id" {
  description = "The Azure AD tenant ID associated with the cluster"
  value       = azurerm_kubernetes_cluster.k8s.identity[0].tenant_id
}

output "resource_group_name" {
  description = "The resource group name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.k8s.resource_group_name
}

output "private_fqdn" {
  description = "The private FQDN for private clusters (null for public clusters)"
  value       = var.aks.private_cluster_enabled ? azurerm_kubernetes_cluster.k8s.private_fqdn : null
}
