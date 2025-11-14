##############################################################################
# Azure Kubernetes Service (AKS) Module - Variables
#
# Comprehensive input configuration for creating and managing an AKS cluster.
# This includes settings for compute, networking, identity, monitoring, 
# security, and maintenance operations.
##############################################################################

variable "aks" {
  description = "Configuration object for the AKS cluster module."
  type = object({
    # Core cluster settings
    name                                = string       # Cluster name (unique within resource group)
    resource_group_name                 = string       # Resource group containing the cluster
    location                            = string       # Azure region (e.g., eastus, westeurope)
    dns_prefix                          = string       # DNS prefix for cluster FQDN
    kubernetes_version                  = string       # Kubernetes version (e.g., 1.28.5)
    private_cluster_enabled             = optional(bool, true)  # Enable private cluster (API server not publicly accessible)
    private_cluster_public_fqdn_enabled = optional(bool, true)  # Provide public FQDN even for private cluster
    private_dns_zone_id                 = string       # Custom private DNS zone resource ID
    sku_tier                            = string       # Free, Standard, or Premium tier
    managed_identity_obj_id             = string       # User-assigned managed identity resource ID
    force_upgrade_enabled               = bool         # Allow forcing cluster upgrades
    azs                                 = list(string) # Availability zones (e.g., ["1", "2", "3"])

    # System node pool configuration - required for cluster control plane components
    default_node_pool = object({
      name                         = string       # Node pool name (lowercase alphanumeric, max 12 chars)
      vm_size                      = string       # Azure VM SKU (e.g., Standard_D4s_v3)
      os_disk_size_gb              = number       # OS disk size in GB
      enable_auto_scaling          = bool         # Enable cluster autoscaler
      min_count                    = number       # Minimum node count for autoscaling
      max_count                    = number       # Maximum node count for autoscaling
      max_pods                     = number       # Maximum pods per node (30-250)
      only_critical_addons_enabled = bool         # Restrict to system pods only
      orchestrator_version         = string       # Kubernetes version for nodes
      container_log_max_line       = number       # Max log lines before rotation
      container_log_max_size_mb    = number       # Max log file size in MB
      node_labels                  = map(string)  # Kubernetes node labels
      vnet_subnet_id               = string       # Subnet resource ID for nodes
    })

    # Network configuration - defines CNI, policies, and connectivity
    network_profile = object({
      network_policy      = string # Network policy provider: azure, calico, or cilium
      network_plugin      = string # CNI plugin: azure or kubenet
      network_plugin_mode = string # overlay or blank (traditional mode)
      outbound_type       = string # loadBalancer, userDefinedRouting, or managedNATGateway
      load_balancer_sku   = string # standard or basic
      service_cidr        = string # CIDR for Kubernetes service IPs
      dns_service_ip      = string # IP address for kube-dns (within service_cidr)
      pod_cidr            = string # CIDR for pod IPs (required for kubenet)
    })

    # Authentication and authorization
    local_account_disabled            = bool   # Disable local Kubernetes admin account
    role_based_access_control_enabled = bool   # Enable Kubernetes RBAC
    azure_rbac_enabled                = bool   # Use Azure RBAC for Kubernetes authorization
    tenant_id                         = string # Azure AD tenant ID

    # Monitoring and observability
    monitor_metrics_config = object({
      annotations_allowed = list(string) # Allowed Prometheus annotation prefixes
      labels_allowed      = list(string) # Allowed Prometheus label prefixes
    })
    law_id                    = optional(string) # Log Analytics workspace ID for Container Insights
    microsoft_defender_law_id = optional(string) # Log Analytics workspace ID for Defender

    # Maintenance windows for upgrades
    maintenance_config = optional(object({
      frequency   = optional(string) # Daily, Weekly, AbsoluteMonthly, RelativeMonthly
      interval    = optional(string) # Interval between maintenance windows
      duration    = optional(string) # Duration in hours
      day_of_week = optional(string) # Day for weekly maintenance
      start_time  = optional(string) # Start time (HH:MM in UTC)
      utc_offset  = optional(string) # UTC offset (e.g., +02:00)
    }))
    
    tags             = map(string) # Resource tags for organization and billing
    acr_login_server = string      # Azure Container Registry login server URL
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
