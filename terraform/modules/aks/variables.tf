variable "aks" {
  description = "Configuration object for the AKS cluster module."
  type = object({
    name                                = string
    resource_group_name                 = string
    location                            = string
    dns_prefix                          = string
    kubernetes_version                  = string
    private_cluster_enabled             = optional(bool, true)
    private_cluster_public_fqdn_enabled = optional(bool, true)
    private_dns_zone_id                 = string
    sku_tier                            = string
    managed_identity_obj_id             = string
    force_upgrade_enabled               = bool
    azs                                 = list(string) # Moved azs inside the object

    # Default node pool configuration
    default_node_pool = object({
      name                         = string
      vm_size                      = string
      os_disk_size_gb              = number
      enable_auto_scaling          = bool
      min_count                    = number
      max_count                    = number
      max_pods                     = number
      only_critical_addons_enabled = bool
      orchestrator_version         = string
      container_log_max_line       = number
      container_log_max_size_mb    = number
      node_labels                  = map(string)
      vnet_subnet_id               = string
    })

    # Network configuration
    network_profile = object({
      network_policy      = string
      network_plugin      = string
      network_plugin_mode = string
      outbound_type       = string
      load_balancer_sku   = string
      service_cidr        = string
      dns_service_ip      = string
      pod_cidr            = string
    })

    # RBAC and AAD configuration
    local_account_disabled            = bool
    role_based_access_control_enabled = bool
    azure_rbac_enabled                = bool
    tenant_id                         = string

    # Monitoring configuration
    monitor_metrics_config = object({
      annotations_allowed = list(string)
      labels_allowed      = list(string)
    })
    law_id                    = optional(string)
    microsoft_defender_law_id = optional(string)

    # Maintenance configuration
    maintenance_config = optional(object({
      frequency   = optional(string)
      interval    = optional(string)
      duration    = optional(string)
      day_of_week = optional(string)
      start_time  = optional(string)
      utc_offset  = optional(string)
    }))
    tags             = map(string)
    acr_login_server = string
  })

  default = {
    name                                = ""
    resource_group_name                 = ""
    location                            = ""
    dns_prefix                          = ""
    kubernetes_version                  = null
    private_cluster_enabled             = false
    private_cluster_public_fqdn_enabled = false
    private_dns_zone_id                 = null
    sku_tier                            = "Free"
    managed_identity_obj_id             = null
    force_upgrade_enabled               = false
    azs                                 = ["1", "2", "3"] # Default availability zones

    default_node_pool = {
      name                         = "system"
      vm_size                      = "Standard_D2s_v3"
      os_disk_size_gb              = 30
      enable_auto_scaling          = false
      min_count                    = null
      max_count                    = null
      max_pods                     = 30
      only_critical_addons_enabled = false
      orchestrator_version         = null
      container_log_max_line       = 5000
      container_log_max_size_mb    = 10
      node_labels                  = {}
      vnet_subnet_id               = null
    }

    network_profile = {
      network_policy      = "calico"
      network_plugin      = "azure"
      network_plugin_mode = "overlay"
      outbound_type       = "userAssignedNATGateway"
      load_balancer_sku   = "standard"
      service_cidr        = "10.0.0.0/16"
      dns_service_ip      = "10.0.0.10"
      pod_cidr            = "10.244.0.0/16"
    }

    local_account_disabled            = true
    role_based_access_control_enabled = true
    azure_rbac_enabled                = true
    tenant_id                         = null

    monitor_metrics_config    = null
    law_id                    = null
    microsoft_defender_law_id = null

    maintenance_config = {}
    tags               = {}
    acr_login_server   = null
  }
}
