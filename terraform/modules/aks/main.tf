# tfsec:ignore:azure-container-logging
# tfsec:ignore:azure-container-limit-authorized-ips
resource "azurerm_kubernetes_cluster" "k8s" {
  name                                = var.aks.name
  location                            = var.aks.location
  resource_group_name                 = var.aks.resource_group_name
  dns_prefix                          = var.aks.dns_prefix
  kubernetes_version                  = var.aks.kubernetes_version
  private_cluster_enabled             = var.aks.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.aks.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.aks.private_dns_zone_id
  sku_tier                            = var.aks.sku_tier

  identity {
    type         = "UserAssigned"
    identity_ids = [var.aks.managed_identity_obj_id]
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = false

  upgrade_override {
    force_upgrade_enabled = var.aks.force_upgrade_enabled
    effective_until       = timeadd(timestamp(), "720h") # 30 days
  }

  default_node_pool {
    name                 = var.aks.default_node_pool.name
    vm_size              = var.aks.default_node_pool.vm_size
    zones                = var.aks.azs
    os_disk_size_gb      = var.aks.default_node_pool.os_disk_size_gb
    vnet_subnet_id       = var.aks.default_node_pool.vnet_subnet_id
    auto_scaling_enabled = var.aks.default_node_pool.enable_auto_scaling
    min_count            = var.aks.default_node_pool.min_count
    max_count            = var.aks.default_node_pool.max_count
    max_pods             = var.aks.default_node_pool.max_pods

    upgrade_settings {
      max_surge = "10%"
    }

    only_critical_addons_enabled = var.aks.default_node_pool.only_critical_addons_enabled
    temporary_name_for_rotation  = "temppool"
    orchestrator_version         = var.aks.kubernetes_version

    kubelet_config {
      container_log_max_line    = var.aks.default_node_pool.container_log_max_line
      container_log_max_size_mb = var.aks.default_node_pool.container_log_max_size_mb
    }

    node_labels = var.aks.default_node_pool.node_labels
    tags        = var.aks.tags
  }

  network_profile {
    network_policy      = var.aks.network_profile.network_policy
    network_plugin      = var.aks.network_profile.network_plugin
    network_plugin_mode = var.aks.network_profile.network_plugin_mode
    outbound_type       = var.aks.network_profile.outbound_type
    load_balancer_sku   = var.aks.network_profile.load_balancer_sku
    service_cidr        = var.aks.network_profile.service_cidr
    dns_service_ip      = var.aks.network_profile.dns_service_ip
    pod_cidr            = var.aks.network_profile.pod_cidr
  }

  local_account_disabled            = var.aks.local_account_disabled
  role_based_access_control_enabled = var.aks.role_based_access_control_enabled

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = var.aks.azure_rbac_enabled
    tenant_id          = var.aks.tenant_id
  }

  dynamic "monitor_metrics" {
    for_each = var.aks.monitor_metrics_config == null ? [] : [var.aks.monitor_metrics_config]
    content {
      annotations_allowed = monitor_metrics.value.annotations_allowed
      labels_allowed      = monitor_metrics.value.labels_allowed
    }
  }

  dynamic "oms_agent" {
    for_each = var.aks.law_id == null ? [] : [1]
    content {
      log_analytics_workspace_id      = var.aks.law_id
      msi_auth_for_monitoring_enabled = true
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.aks.microsoft_defender_law_id == null ? [] : [1]
    content {
      log_analytics_workspace_id = var.aks.microsoft_defender_law_id
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
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

  tags = merge(var.aks.tags, { "acr_login_server" = var.aks.acr_login_server })

  lifecycle {
    ignore_changes = [
      upgrade_override
    ]
  }
}
