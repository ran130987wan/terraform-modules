# apim-apis

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
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_apis"></a> [apim\_apis](#input\_apim\_apis) | Configuration for API Management APIs to create. | <pre>object({<br/>    api_management_name = string<br/>    resource_group_name = string<br/>    apis = list(object({<br/>      name                  = string           # logical key (api_id)<br/>      display_name          = optional(string) # defaults to name<br/>      description           = optional(string, "")<br/>      path                  = string                            # public path segment<br/>      protocols             = optional(list(string), ["https"]) # http/https<br/>      subscription_required = optional(bool, true)<br/>      service_url           = optional(string) # backend URL<br/>      revision              = optional(string, "1")<br/>      version               = optional(string)<br/>      version_set_id        = optional(string)<br/>      api_type              = optional(string, "http") # http, graphql, websocket (azureRM provider supported subset)<br/>      import_format         = optional(string)         # swagger, openapi, wsdl etc<br/>      import_content        = optional(string)         # raw spec content (inline)<br/>      import_path           = optional(string)         # file path to local spec (will use file() if set)<br/>    }))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_ids"></a> [api\_ids](#output\_api\_ids) | Map of API logical names to resource IDs. |
| <a name="output_api_paths"></a> [api\_paths](#output\_api\_paths) | Map of API logical names to public paths. |
<!-- END_TF_DOCS -->
