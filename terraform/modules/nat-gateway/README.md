# nat-gateway

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
| [azurerm_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | Configuration object for Azure NAT Gateway | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>    location            = string<br/>    sku                 = string<br/>    tags                = map(string)<br/>  })</pre> | <pre>{<br/>  "location": "",<br/>  "name": "",<br/>  "resource_group_name": "",<br/>  "sku": "Standard",<br/>  "tags": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | n/a |
| <a name="output_nat_gateway_location"></a> [nat\_gateway\_location](#output\_nat\_gateway\_location) | n/a |
| <a name="output_nat_gateway_name"></a> [nat\_gateway\_name](#output\_nat\_gateway\_name) | n/a |
<!-- END_TF_DOCS -->
