resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = var.aks_node.node_pool_name
  kubernetes_cluster_id = var.aks_node.kubernetes_cluster_id

  vm_size = var.aks_node.vm_size
  mode    = var.aks_node.mode

  # Fixed count vs autoscaler
  auto_scaling_enabled = var.aks_node.enable_auto_scaling
  node_count           = var.aks_node.enable_auto_scaling ? var.aks_node.node_count : null
  min_count            = var.aks_node.enable_auto_scaling ? var.aks_node.min_count : null
  max_count            = var.aks_node.enable_auto_scaling ? var.aks_node.max_count : null

  os_type         = var.aks_node.os_type
  os_disk_size_gb = var.aks_node.os_disk_size_gb

  upgrade_settings {
    max_surge = "10%"
  }

  vnet_subnet_id = var.aks_node.vnet_subnet_id
  max_pods       = var.aks_node.max_pods

  node_labels = var.aks_node.node_labels
  node_taints = var.aks_node.node_taints

  zones = length(var.aks_node.availability_zones) > 0 ? var.aks_node.availability_zones : null

  orchestrator_version        = var.aks_node.orchestrator_version
  temporary_name_for_rotation = "tmprotate"

  tags = var.aks_node.tags

  lifecycle {
    ignore_changes = [
      # Let AKS change this during upgrades if necessary
      orchestrator_version
    ]
  }
}
