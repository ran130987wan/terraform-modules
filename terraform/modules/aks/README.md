# aks

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
| [azurerm_kubernetes_cluster.k8s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks"></a> [aks](#input\_aks) | Configuration object for the AKS cluster module. | <pre>object({<br/>    name                                = string<br/>    resource_group_name                 = string<br/>    location                            = string<br/>    dns_prefix                          = string<br/>    kubernetes_version                  = string<br/>    private_cluster_enabled             = optional(bool, true)<br/>    private_cluster_public_fqdn_enabled = optional(bool, true)<br/>    private_dns_zone_id                 = string<br/>    sku_tier                            = string<br/>    managed_identity_obj_id             = string<br/>    force_upgrade_enabled               = bool<br/>    azs                                 = list(string) # Moved azs inside the object<br/><br/>    # Default node pool configuration<br/>    default_node_pool = object({<br/>      name                         = string<br/>      vm_size                      = string<br/>      os_disk_size_gb              = number<br/>      enable_auto_scaling          = bool<br/>      min_count                    = number<br/>      max_count                    = number<br/>      max_pods                     = number<br/>      only_critical_addons_enabled = bool<br/>      orchestrator_version         = string<br/>      container_log_max_line       = number<br/>      container_log_max_size_mb    = number<br/>      node_labels                  = map(string)<br/>      vnet_subnet_id               = string<br/>    })<br/><br/>    # Network configuration<br/>    network_profile = object({<br/>      network_policy      = string<br/>      network_plugin      = string<br/>      network_plugin_mode = string<br/>      outbound_type       = string<br/>      load_balancer_sku   = string<br/>      service_cidr        = string<br/>      dns_service_ip      = string<br/>      pod_cidr            = string<br/>    })<br/><br/>    # RBAC and AAD configuration<br/>    local_account_disabled            = bool<br/>    role_based_access_control_enabled = bool<br/>    azure_rbac_enabled                = bool<br/>    tenant_id                         = string<br/><br/>    # Monitoring configuration<br/>    monitor_metrics_config = object({<br/>      annotations_allowed = list(string)<br/>      labels_allowed      = list(string)<br/>    })<br/>    law_id                    = optional(string)<br/>    microsoft_defender_law_id = optional(string)<br/><br/>    # Maintenance configuration<br/>    maintenance_config = optional(object({<br/>      frequency   = optional(string)<br/>      interval    = optional(string)<br/>      duration    = optional(string)<br/>      day_of_week = optional(string)<br/>      start_time  = optional(string)<br/>      utc_offset  = optional(string)<br/>    }))<br/>    tags             = map(string)<br/>    acr_login_server = string<br/>  })</pre> | <pre>{<br/>  "acr_login_server": null,<br/>  "azs": [<br/>    "1",<br/>    "2",<br/>    "3"<br/>  ],<br/>  "azure_rbac_enabled": true,<br/>  "default_node_pool": {<br/>    "container_log_max_line": 5000,<br/>    "container_log_max_size_mb": 10,<br/>    "enable_auto_scaling": false,<br/>    "max_count": null,<br/>    "max_pods": 30,<br/>    "min_count": null,<br/>    "name": "system",<br/>    "node_labels": {},<br/>    "only_critical_addons_enabled": false,<br/>    "orchestrator_version": null,<br/>    "os_disk_size_gb": 30,<br/>    "vm_size": "Standard_D2s_v3",<br/>    "vnet_subnet_id": null<br/>  },<br/>  "dns_prefix": "",<br/>  "force_upgrade_enabled": false,<br/>  "kubernetes_version": null,<br/>  "law_id": null,<br/>  "local_account_disabled": true,<br/>  "location": "",<br/>  "maintenance_config": {},<br/>  "managed_identity_obj_id": null,<br/>  "microsoft_defender_law_id": null,<br/>  "monitor_metrics_config": null,<br/>  "name": "",<br/>  "network_profile": {<br/>    "dns_service_ip": "10.0.0.10",<br/>    "load_balancer_sku": "standard",<br/>    "network_plugin": "azure",<br/>    "network_plugin_mode": "overlay",<br/>    "network_policy": "calico",<br/>    "outbound_type": "userAssignedNATGateway",<br/>    "pod_cidr": "10.244.0.0/16",<br/>    "service_cidr": "10.0.0.0/16"<br/>  },<br/>  "private_cluster_enabled": false,<br/>  "private_cluster_public_fqdn_enabled": false,<br/>  "private_dns_zone_id": null,<br/>  "resource_group_name": "",<br/>  "role_based_access_control_enabled": true,<br/>  "sku_tier": "Free",<br/>  "tags": {},<br/>  "tenant_id": null<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | n/a |
| <a name="output_aks_kubelet_identity_client_id"></a> [aks\_kubelet\_identity\_client\_id](#output\_aks\_kubelet\_identity\_client\_id) | n/a |
| <a name="output_aks_managed_identity"></a> [aks\_managed\_identity](#output\_aks\_managed\_identity) | n/a |
| <a name="output_aks_managed_identity_id"></a> [aks\_managed\_identity\_id](#output\_aks\_managed\_identity\_id) | n/a |
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | n/a |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the cluster |
| <a name="output_cluster_username"></a> [cluster\_username](#output\_cluster\_username) | n/a |
| <a name="output_effective_outbound_ips"></a> [effective\_outbound\_ips](#output\_effective\_outbound\_ips) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_id"></a> [id](#output\_id) | The ID of the cluster |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | n/a |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->
