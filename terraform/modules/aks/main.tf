          ##############################################################################
# Azure Kubernetes Service (AKS) Module
#
# This module creates and configures an Azure Kubernetes Service cluster with
# comprehensive settings for networking, security, monitoring, and high availability.
#
# Features:
# - Private or public cluster configuration
# - User-assigned managed identity
# - OIDC issuer for workload identity federation
# - Auto-scaling and multi-zone support
# - Azure CNI or Kubenet networking
# - Azure AD integration with RBAC
# - Container Insights and Microsoft Defender integration
# - Configurable maintenance windows
##############################################################################

# tfsec:ignore:azure-container-logging - Custom logging configuration via Container Insights
# tfsec:ignore:azure-container-limit-authorized-ips - Network policy managed separately
resource "azurerm_kubernetes_cluster" "k8s" {
  # Basic cluster configuration
  name                = var.aks.name
  location            = var.aks.location
  resource_group_name = var.aks.resource_group_name
  dns_prefix          = var.aks.dns_prefix             # DNS prefix for the cluster FQDN
  kubernetes_version  = var.aks.kubernetes_version     # K8s version (e.g., 1.28.5)
  
  # Private cluster settings
  private_cluster_enabled             = var.aks.private_cluster_enabled             # Enable private cluster (no public API endpoint)
  private_cluster_public_fqdn_enabled = var.aks.private_cluster_public_fqdn_enabled # Expose public FQDN for private cluster
  private_dns_zone_id                 = var.aks.private_dns_zone_id                 # Custom private DNS zone ID
  sku_tier                            = var.aks.sku_tier                            # Free, Standard, or Premium

  # Managed identity for cluster operations
  identity {
    type         = "UserAssigned"
    identity_ids = [var.aks.managed_identity_obj_id] # User-assigned identity for cluster control plane
  }

  # Workload identity federation settings
  oidc_issuer_enabled       = true  # Enable OIDC issuer for workload identity
  workload_identity_enabled = false # Workload identity feature flag

  # Cluster upgrade control - allows forcing upgrades during maintenance
  upgrade_override {
    force_upgrade_enabled = var.aks.force_upgrade_enabled
    effective_until       = timeadd(timestamp(), "720h") # Valid for 30 days
  }

  # System node pool configuration - critical for cluster operations
  default_node_pool {
    name                 = var.aks.default_node_pool.name
    vm_size              = var.aks.default_node_pool.vm_size         # VM SKU (e.g., Standard_D4s_v3)
    zones                = var.aks.azs                               # Availability zones for high availability
    os_disk_size_gb      = var.aks.default_node_pool.os_disk_size_gb
    vnet_subnet_id       = var.aks.default_node_pool.vnet_subnet_id # Subnet for node placement
    
    # Auto-scaling configuration
    auto_scaling_enabled = var.aks.default_node_pool.enable_auto_scaling
    min_count            = var.aks.default_node_pool.min_count       # Minimum nodes when auto-scaling
    max_count            = var.aks.default_node_pool.max_count       # Maximum nodes when auto-scaling
    max_pods             = var.aks.default_node_pool.max_pods        # Max pods per node

    # Node upgrade settings - controls rolling upgrade behavior
    upgrade_settings {
      max_surge = "10%" # Additional nodes during upgrade (percentage or count)
    }

    only_critical_addons_enabled = var.aks.default_node_pool.only_critical_addons_enabled # Restrict to system pods only
    temporary_name_for_rotation  = "temppool"                                             # Temp name during node pool rotation
    orchestrator_version         = var.aks.kubernetes_version                             # K8s version for nodes

    # Kubelet configuration for container logging
    kubelet_config {
      container_log_max_line    = var.aks.default_node_pool.container_log_max_line    # Max log lines before rotation
      container_log_max_size_mb = var.aks.default_node_pool.container_log_max_size_mb # Max log file size
    }

    node_labels = var.aks.default_node_pool.node_labels # Custom K8s labels for node selection
    tags        = var.aks.tags
  }

  # Network configuration - defines cluster networking model
  network_profile {
    network_policy      = var.aks.network_profile.network_policy      # Azure, Calico, or Cilium
    network_plugin      = var.aks.network_profile.network_plugin      # azure (CNI) or kubenet
    network_plugin_mode = var.aks.network_profile.network_plugin_mode # overlay or blank
    outbound_type       = var.aks.network_profile.outbound_type       # loadBalancer, userDefinedRouting, etc.
    load_balancer_sku   = var.aks.network_profile.load_balancer_sku   # standard or basic
    service_cidr        = var.aks.network_profile.service_cidr        # CIDR for K8s services
    dns_service_ip      = var.aks.network_profile.dns_service_ip      # IP for kube-dns service
    pod_cidr            = var.aks.network_profile.pod_cidr            # CIDR for pod IPs (kubenet only)
  }

  # Access control settings
  local_account_disabled            = var.aks.local_account_disabled            # Disable local admin account
  role_based_access_control_enabled = var.aks.role_based_access_control_enabled # Enable K8s RBAC

  # Azure AD integration for authentication and authorization
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = var.aks.azure_rbac_enabled # Use Azure RBAC for K8s authorization
    tenant_id          = var.aks.tenant_id          # Azure AD tenant ID
  }

  # Prometheus metrics collection configuration
  dynamic "monitor_metrics" {
    for_each = var.aks.monitor_metrics_config == null ? [] : [var.aks.monitor_metrics_config]
    content {
      annotations_allowed = monitor_metrics.value.annotations_allowed # Allowed annotation prefixes
      labels_allowed      = monitor_metrics.value.labels_allowed      # Allowed label prefixes
    }
  }

  # Container Insights (OMS agent) for monitoring and logging
  dynamic "oms_agent" {
    for_each = var.aks.law_id == null ? [] : [1]
    content {
      log_analytics_workspace_id      = var.aks.law_id # Log Analytics workspace for Container Insights
      msi_auth_for_monitoring_enabled = true           # Use managed identity for authentication
    }
  }

  # Microsoft Defender for Containers security monitoring
  dynamic "microsoft_defender" {
    for_each = var.aks.microsoft_defender_law_id == null ? [] : [1]
    content {
      log_analytics_workspace_id = var.aks.microsoft_defender_law_id # Log Analytics for security data
    }
  }

  # Maintenance window for automatic cluster upgrades
  dynamic "maintenance_window_auto_upgrade" {
    for_each = var.aks.maintenance_config == null ? {} : var.aks.maintenance_config
    content {
      frequency   = var.aks.maintenance_config.frequency   # Daily, Weekly, etc.
      interval    = var.aks.maintenance_config.interval    # Interval value
      duration    = var.aks.maintenance_config.duration    # Duration in hours
      day_of_week = var.aks.maintenance_config.day_of_week # For weekly schedules
      start_time  = var.aks.maintenance_config.start_time  # HH:MM format
      utc_offset  = var.aks.maintenance_config.utc_offset  # Timezone offset
    }
  }
  
  # Maintenance window for node OS image upgrades
  dynamic "maintenance_window_node_os" {
    for_each = var.aks.maintenance_config == null ? {} : var.aks.maintenance_config
    content {
      frequency   = var.aks.maintenance_config.frequency
      interval    = var.aks.maintenance_config.interval
      duration    = var.aks.maintenance_config.duration
      day_of_week = var.aks.maintenance_config.day_of_week
      start_time  = var.aks.maintenance_config.start_time
      utc_offset  = var.aks.maintenance_config.utc_offset
    }
  }

  # Merge default tags with ACR login server for reference
  tags = merge(var.aks.tags, { "acr_login_server" = var.aks.acr_login_server })

  # Prevent Terraform from changing upgrade_override on subsequent applies
  lifecycle {
    ignore_changes = [
      upgrade_override
    ]
  }
}
