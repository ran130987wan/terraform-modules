variable "aks_node" {
  description = "Configuration object for the AKS node pool, including cluster ID, scaling, naming, labels, etc."

  type = object({
    kubernetes_cluster_id = string
    node_pool_name        = string
    vm_size               = string
    enable_auto_scaling   = bool
    node_count            = number
    min_count             = number
    max_count             = number
    mode                  = string
    vnet_subnet_id        = string
    availability_zones    = list(string)
    node_labels           = map(string)
    node_taints           = list(string)
    os_disk_size_gb       = number
    os_type               = string
    max_pods              = number
    orchestrator_version  = string
    tags                  = map(string)
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