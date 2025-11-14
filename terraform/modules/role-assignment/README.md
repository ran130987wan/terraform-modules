# role-assignment

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
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | Configuration object for the Role Assignment. | <pre>object({<br/>    scope                            = string<br/>    principal_id                     = string<br/>    principal_type                   = optional(string)<br/>    role_definition_name             = optional(string)<br/>    role_definition_id               = optional(string)<br/>    condition                        = optional(string)<br/>    condition_version                = optional(string)<br/>    description                      = optional(string, "")<br/>    skip_service_principal_aad_check = optional(bool, false)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the role assignment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the role assignment. |
<!-- END_TF_DOCS -->
