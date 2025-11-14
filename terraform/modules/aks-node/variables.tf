##############################################################################
# AKS Node Pool Module - Variables
#
# Input configuration for creating additional node pools in an AKS cluster.
# Node pools enable workload isolation with different VM sizes, scaling
# policies, and Kubernetes scheduling constraints.
##############################################################################

variable "aks_node" {
  description = "Configuration object for the AKS node pool, including cluster ID, scaling, naming, labels, etc."

  type = object({
    kubernetes_cluster_id = string       # Resource ID of the parent AKS cluster
    node_pool_name        = string       # Node pool name (lowercase alphanumeric, max 12 chars)
    vm_size               = string       # Azure VM SKU (e.g., Standard_D4s_v3, Standard_E8s_v3)
    enable_auto_scaling   = bool         # Enable cluster autoscaler for this pool
    node_count            = number       # Initial/fixed node count
    min_count             = number       # Minimum nodes when autoscaling enabled
    max_count             = number       # Maximum nodes when autoscaling enabled
    mode                  = string       # User (application workloads) or System (critical add-ons)
    vnet_subnet_id        = string       # Subnet resource ID for node placement
    availability_zones    = list(string) # Availability zones (e.g., ["1", "2", "3"])
    node_labels           = map(string)  # Kubernetes node labels for pod scheduling
    node_taints           = list(string) # Node taints (format: "key=value:effect")
    os_disk_size_gb       = number       # OS disk size in GB
    os_type               = string       # Linux or Windows
    max_pods              = number       # Maximum pods per node (30-250 for Azure CNI)
    orchestrator_version  = string       # Kubernetes version (should match or trail cluster)
    tags                  = map(string)  # Resource tags for organization and billing
  })

  default = {
    kubernetes_cluster_id = ""
    node_pool_name        = ""
    vm_size               = "Standard_B2ms"
    enable_auto_scaling   = false
    node_count            = 1
    min_count             = 1
    max_count             = 3
    mode                  = "User"
    vnet_subnet_id        = null
    availability_zones    = []
    node_labels           = {}
    node_taints           = []
    os_disk_size_gb       = 128
    os_type               = "Linux"
    max_pods              = null
    orchestrator_version  = null
    tags                  = {}
  }
}