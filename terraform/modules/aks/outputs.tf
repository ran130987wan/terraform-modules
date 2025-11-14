output "id" {
  description = "The ID of the cluster"
  value       = azurerm_kubernetes_cluster.k8s.id
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = azurerm_kubernetes_cluster.k8s.name
}
output "client_key" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
}
output "client_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
}
output "cluster_ca_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
}
output "cluster_username" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
}
output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}
output "host" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].host
}
output "node_resource_group" {
  value = azurerm_kubernetes_cluster.k8s.node_resource_group
}
output "effective_outbound_ips" {
  value = azurerm_kubernetes_cluster.k8s.network_profile[0].load_balancer_profile[0].effective_outbound_ips
}
output "fqdn" {
  description = "The fully qualified domain name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.k8s.fqdn
}

output "aks_managed_identity" {
  description = "The object ID of the AKS managed identity"
  value       = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}

output "aks_kubelet_identity_client_id" {
  description = "The client ID of the AKS kubelet identity"
  value       = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].client_id
}

output "aks_managed_identity_id" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].user_assigned_identity_id
}

output "tenant_id" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].tenant_id
}

output "resource_group_name" {
  description = "The resource group name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.k8s.resource_group_name
}

output "private_fqdn" {
  value = var.aks.private_cluster_enabled ? azurerm_kubernetes_cluster.k8s.private_fqdn : null
}
