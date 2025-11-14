# apim

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
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim"></a> [apim](#input\_apim) | API Management configuration. | <pre>object({<br/>    name                      = string<br/>    resource_group_name       = string<br/>    location                  = string<br/>    publisher_email           = string<br/>    publisher_name            = string<br/>    sku_name                  = optional(string, "Developer_1") # (Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, BasicV2, Standard, StandardV2, Premium and PremiumV2. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).<br/>    tags                      = optional(map(string), {})<br/>    identity_type             = optional(string) # SystemAssigned, UserAssigned, SystemAssigned,UserAssigned<br/>    identity_ids              = optional(list(string), [])<br/>    virtual_network_type      = optional(string, null) # None / External / Internal<br/>    virtual_network_subnet_id = optional(string, null)<br/>    public_network_access     = optional(string, "Enabled") # Enabled / Disabled<br/>    zones                     = optional(list(string), [])<br/>    protocols                 = optional(list(string), ["http", "https"])<br/>    enable_client_certificate = optional(bool, false)<br/>    enable_managed_identity   = optional(bool, true)<br/>    notification_sender_email = optional(string, null)<br/>    gateway_disabled          = optional(bool, false)<br/>    publisher_portal_disabled = optional(bool, false)<br/>    min_api_version           = optional(string, "2019-12-01")<br/>    additional_locations = optional(list(object({<br/>      location             = string<br/>      capacity             = number<br/>      gateway_disabled     = optional(bool, false)<br/>      public_ip_address_id = optional(string, null)<br/>      zones                = optional(list(string), [])<br/>      subnet_id            = optional(string)<br/>    })), [])<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The gateway URL of the API Management instance. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the API Management instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the API Management instance. |
| <a name="output_portal_url"></a> [portal\_url](#output\_portal\_url) | The developer portal URL of the API Management instance. |
<!-- END_TF_DOCS -->
