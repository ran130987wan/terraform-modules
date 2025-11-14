##############################################################################
# AKS Node Pool Module
#
# This module creates an additional node pool for an existing AKS cluster.
# Node pools allow you to have different VM sizes, scaling policies, and
# configurations for different workload types.
#
# Features:
# - Support for User and System mode pools
# - Auto-scaling with min/max bounds
# - Custom node labels and taints for pod scheduling
# - Multi-zone deployment for high availability
# - Flexible OS disk sizing
##############################################################################

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  # Basic node pool configuration
  name                  = var.aks_node.node_pool_name        # Pool name (lowercase alphanumeric, max 12 chars)
  kubernetes_cluster_id = var.aks_node.kubernetes_cluster_id # Parent AKS cluster resource ID

  vm_size = var.aks_node.vm_size # Azure VM SKU (e.g., Standard_D4s_v3)
  mode    = var.aks_node.mode    # User (workloads) or System (critical add-ons)

  # Scaling configuration - either fixed count or autoscaling
  auto_scaling_enabled = var.aks_node.enable_auto_scaling
  node_count           = var.aks_node.enable_auto_scaling ? var.aks_node.node_count : null # Initial count for autoscaler
  min_count            = var.aks_node.enable_auto_scaling ? var.aks_node.min_count : null   # Minimum nodes
  max_count            = var.aks_node.enable_auto_scaling ? var.aks_node.max_count : null   # Maximum nodes

  # Operating system configuration
  os_type         = var.aks_node.os_type         # Linux or Windows
  os_disk_size_gb = var.aks_node.os_disk_size_gb # OS disk size in GB

  # Node upgrade settings - controls rolling upgrade behavior
  upgrade_settings {
    max_surge = "10%" # Additional nodes during upgrade (percentage or count)
  }

  # Network configuration
  vnet_subnet_id = var.aks_node.vnet_subnet_id # Subnet for node placement
  max_pods       = var.aks_node.max_pods       # Maximum pods per node (30-250)

  # Kubernetes scheduling controls
  node_labels = var.aks_node.node_labels # Custom labels for pod node selectors
  node_taints = var.aks_node.node_taints # Taints to restrict pod scheduling

  # High availability - distribute nodes across availability zones
  zones = length(var.aks_node.availability_zones) > 0 ? var.aks_node.availability_zones : null

  # Kubernetes version management
  orchestrator_version        = var.aks_node.orchestrator_version # K8s version for this pool
  temporary_name_for_rotation = "tmprotate"                       # Temp name during pool rotation

  tags = var.aks_node.tags

  lifecycle {
    ignore_changes = [
      orchestrator_version # Allow AKS to manage version upgrades
    ]
  }
}
