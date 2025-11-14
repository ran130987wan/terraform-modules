# private-dns-resolver

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
| [azurerm_private_dns_resolver.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_virtual_network_dns_servers.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_resolver"></a> [dns\_resolver](#input\_dns\_resolver) | Configuration object for the Azure Private DNS Resolver. | <pre>object({<br/>    name                = string<br/>    location            = string<br/>    resource_group_name = string<br/>    virtual_network_id  = string<br/>    inbound_subnet_id   = string<br/>    outbound_subnet_id  = string<br/>    tags                = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "inbound_subnet_id": "",<br/>  "location": "",<br/>  "name": "",<br/>  "outbound_subnet_id": "",<br/>  "resource_group_name": "",<br/>  "tags": {},<br/>  "virtual_network_id": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS Resolver. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private DNS Resolver. |
<!-- END_TF_DOCS -->
