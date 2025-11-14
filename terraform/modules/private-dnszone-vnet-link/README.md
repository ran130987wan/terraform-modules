# private-dnszone-vnet-link

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone_vnet_link"></a> [dns\_zone\_vnet\_link](#input\_dns\_zone\_vnet\_link) | Configuration object for the Private DNS Zone Virtual Network Link. | <pre>object({<br/>    name                  = string<br/>    resource_group_name   = string<br/>    private_dns_zone_name = string<br/>    virtual_network_id    = string<br/>    registration_enabled  = optional(bool, false)<br/>    resolution_policy     = optional(string) # Possible values: "Default" and "NxDomainRedirect"<br/>    tags                  = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "name": "",<br/>  "private_dns_zone_name": "",<br/>  "registration_enabled": false,<br/>  "resolution_policy": "Default",<br/>  "resource_group_name": "",<br/>  "virtual_network_id": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS Zone Virtual Network Link. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private DNS Zone Virtual Network Link. |
<!-- END_TF_DOCS -->
