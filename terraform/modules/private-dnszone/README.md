# private-dnszone

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
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | Configuration object for the Private DNS Zone. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>    tags                = optional(map(string), {})<br/>    soa_record = optional(object({<br/>      email        = string<br/>      expire_time  = optional(number, 2419200)<br/>      minimum_ttl  = optional(number, 10)<br/>      refresh_time = optional(number, 3600)<br/>      retry_time   = optional(number, 300)<br/>      ttl          = optional(number, 3600)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "name": "",<br/>  "resource_group_name": "",<br/>  "tags": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS Zone. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private DNS Zone. |
<!-- END_TF_DOCS -->
