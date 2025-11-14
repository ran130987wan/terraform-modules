# static-web-app

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
| [azurerm_static_web_app.static_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_staticwebapp"></a> [staticwebapp](#input\_staticwebapp) | n/a | <pre>object({<br/>    name                               = string<br/>    resource_group_name                = string<br/>    location                           = string<br/>    tags                               = optional(map(string))<br/>    configuration_file_changes_enabled = optional(bool, true)<br/>    preview_environments_enabled       = optional(bool, true)<br/>    public_network_access_enabled      = optional(bool, true)<br/>    sku_tier                           = optional(string, "Free")<br/>    sku_size                           = optional(string, "Free")<br/><br/>    app_settings       = optional(map(string))<br/>    basic_auth_enabled = bool<br/>    basic_auth = optional(object({<br/>      environments = optional(string)<br/>      password     = optional(string)<br/>    }), {})<br/><br/>    identity = optional(object({<br/>      type = string<br/>    }))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the static web app |
| <a name="output_name"></a> [name](#output\_name) | The name of the static web app |
| <a name="output_resource_uri"></a> [resource\_uri](#output\_resource\_uri) | The default hostname of the static web app |
<!-- END_TF_DOCS -->
