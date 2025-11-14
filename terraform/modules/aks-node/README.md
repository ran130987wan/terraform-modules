# aks-node

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_node"></a> [aks\_node](#input\_aks\_node) | Configuration object for the AKS node pool, including cluster ID, scaling, naming, labels, etc. | <pre>object({<br/>    kubernetes_cluster_id = string<br/>    node_pool_name        = string<br/>    vm_size               = string<br/>    enable_auto_scaling   = bool<br/>    node_count            = number<br/>    min_count             = number<br/>    max_count             = number<br/>    mode                  = string<br/>    vnet_subnet_id        = string<br/>    availability_zones    = list(string)<br/>    node_labels           = map(string)<br/>    node_taints           = list(string)<br/>    os_disk_size_gb       = number<br/>    os_type               = string<br/>    max_pods              = number<br/>    orchestrator_version  = string<br/>    tags                  = map(string)<br/>  })</pre> | <pre>{<br/>  "availability_zones": [],<br/>  "enable_auto_scaling": false,<br/>  "kubernetes_cluster_id": "",<br/>  "max_count": 3,<br/>  "max_pods": null,<br/>  "min_count": 1,<br/>  "mode": "User",<br/>  "node_count": 1,<br/>  "node_labels": {},<br/>  "node_pool_name": "",<br/>  "node_taints": [],<br/>  "orchestrator_version": null,<br/>  "os_disk_size_gb": 128,<br/>  "os_type": "Linux",<br/>  "tags": {},<br/>  "vm_size": "Standard_B2ms",<br/>  "vnet_subnet_id": null<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling"></a> [autoscaling](#output\_autoscaling) | Autoscaling settings as requested. |
| <a name="output_effective_node_count"></a> [effective\_node\_count](#output\_effective\_node\_count) | Requested node count when autoscaling is disabled; null otherwise. |
| <a name="output_id"></a> [id](#output\_id) | Node pool resource ID. |
| <a name="output_name"></a> [name](#output\_name) | Name of the node pool. |
<!-- END_TF_DOCS -->
