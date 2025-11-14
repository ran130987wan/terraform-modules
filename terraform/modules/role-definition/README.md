# role-definition

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
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_role_definition"></a> [role\_definition](#input\_role\_definition) | Configuration object for creating an Azure custom Role Definition (or referencing with provided GUID). | <pre>object({<br/>    name               = string # Display name of role<br/>    scope              = string # Management group or subscription scope<br/>    description        = optional(string, "")<br/>    role_definition_id = optional(string) # Predefined GUID if you want deterministic ID<br/>    permissions = list(object({<br/>      actions          = optional(list(string), [])<br/>      not_actions      = optional(list(string), [])<br/>      data_actions     = optional(list(string), [])<br/>      not_data_actions = optional(list(string), [])<br/>    }))<br/>    assignable_scopes = optional(list(string)) # Defaults to [scope] if omitted<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully qualified ID of the role definition. |
| <a name="output_name"></a> [name](#output\_name) | The name of the role definition. |
| <a name="output_role_definition_id"></a> [role\_definition\_id](#output\_role\_definition\_id) | The GUID of the role definition (role\_definition\_id). |
<!-- END_TF_DOCS -->
