# private-link-service

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
| [azurerm_private_link_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_link_service"></a> [private\_link\_service](#input\_private\_link\_service) | Configuration object for the Private Link Service. | <pre>object({<br/>    name                                        = string<br/>    location                                    = string<br/>    resource_group_name                         = string<br/>    load_balancer_frontend_ip_configuration_ids = list(string)<br/>    auto_approval_subscription_ids              = optional(list(string), [])<br/>    visibility_subscription_ids                 = optional(list(string), [])<br/>    fqdns                                       = optional(list(string), [])<br/>    nat_ip_configuration = optional(object({<br/>      name                       = string<br/>      subnet_id                  = string<br/>      private_ip_address         = optional(string)<br/>      private_ip_address_version = optional(string, "IPv4")<br/>      primary                    = optional(bool, true)<br/>    }))<br/>    tags = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "auto_approval_subscription_ids": [],<br/>  "fqdns": [],<br/>  "load_balancer_frontend_ip_configuration_ids": [],<br/>  "location": "",<br/>  "name": "",<br/>  "nat_ip_configuration": null,<br/>  "resource_group_name": "",<br/>  "tags": {},<br/>  "visibility_subscription_ids": []<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias"></a> [alias](#output\_alias) | The alias of the Private Link Service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Link Service. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private Link Service. |
<!-- END_TF_DOCS -->
