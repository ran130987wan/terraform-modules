# private-dns-a-record

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
| [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_dns_a_record"></a> [private\_dns\_a\_record](#input\_private\_dns\_a\_record) | Configuration object for the Private DNS A record. | <pre>object({<br/>    name                = string<br/>    zone_name           = string<br/>    resource_group_name = string<br/>    ttl                 = optional(number, 300)<br/>    records             = list(string)<br/>    enabled             = optional(bool, true)<br/>    tags                = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "enabled": true,<br/>  "name": "",<br/>  "records": [],<br/>  "resource_group_name": "",<br/>  "tags": {},<br/>  "ttl": 300,<br/>  "zone_name": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name (FQDN) of the Private DNS A record. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS A record. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private DNS A record. |
<!-- END_TF_DOCS -->
