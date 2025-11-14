output "id" {
  description = "Node pool resource ID."
  value       = azurerm_kubernetes_cluster_node_pool.this.id
}

output "name" {
  description = "Name of the node pool."
  value       = azurerm_kubernetes_cluster_node_pool.this.name
}

output "effective_node_count" {
  description = "Requested node count when autoscaling is disabled; null otherwise."
  value       = var.aks_node.enable_auto_scaling ? null : var.aks_node.node_count
}

output "autoscaling" {
  description = "Autoscaling settings as requested."
  value = var.aks_node.enable_auto_scaling ? {
    enabled = true
    min     = var.aks_node.min_count
    max     = var.aks_node.max_count
    } : {
    enabled = false
    min     = null
    max     = null
  }
}