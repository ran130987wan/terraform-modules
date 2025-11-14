# cosmosdb-sql-role-assignment

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_sql_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_role_assignment) | resource |
| [random_uuid.assignment](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmosdb_account"></a> [cosmosdb\_account](#input\_cosmosdb\_account) | Existing Cosmos DB account to attach SQL databases to (created externally or by another module). | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | Cosmos DB SQL role assignments. Each value configures a role assignment resource. | <pre>object({<br/>    principal_id       = string # Object ID of the principal (user, group, service principal) to assign the role to<br/>    scope              = string # Override scope; defaults to account ID or module-level scope<br/>    role_definition_id = string # Override role definition ID; defaults to module-level role_definition_id<br/>  })</pre> | <pre>{<br/>  "principal_id": "",<br/>  "role_definition_id": "",<br/>  "scope": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cosmos DB SQL role assignment |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cosmos DB SQL role assignment |
<!-- END_TF_DOCS -->
