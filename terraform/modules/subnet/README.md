# subnet

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
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets to create inside the VNet. Supports optional service endpoints and delegations. | <pre>list(object({<br/>    name                 = string<br/>    resource_group_name  = string<br/>    virtual_network_name = string<br/>    address_prefixes     = list(string)<br/>    service_endpoints    = optional(list(string), [])<br/>    delegations = optional(list(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name    = string<br/>        actions = list(string)<br/>      })<br/>    })), [])<br/>    private_link_service_network_policies_disabled = optional(bool, false)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | Map of address prefix lists keyed by subnet name. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map of subnet IDs keyed by subnet name. |
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | List of subnet names created. |
| <a name="output_subnet_resource_group_names"></a> [subnet\_resource\_group\_names](#output\_subnet\_resource\_group\_names) | Map of resource group names keyed by subnet name. |
| <a name="output_subnet_virtual_network_names"></a> [subnet\_virtual\_network\_names](#output\_subnet\_virtual\_network\_names) | Map of virtual network names keyed by subnet name. |
<!-- END_TF_DOCS -->
