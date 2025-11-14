# cosmosdb-sql-role-definition

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
| [azurerm_cosmosdb_sql_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmosdb_account"></a> [cosmosdb\_account](#input\_cosmosdb\_account) | Existing Cosmos DB account to attach SQL databases to (created externally or by another module). | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_role_definition"></a> [role\_definition](#input\_role\_definition) | Cosmos DB SQL role definitions. Each value configures a role definition resource. | <pre>object({<br/>    name              = string # Role name (display)<br/>    type              = optional(string, "CustomRole")<br/>    data_actions      = list(string)           # Allowed data actions<br/>    not_data_actions  = optional(list(string)) # Explicitly denied data actions<br/>    assignable_scopes = optional(list(string)) # Override scopes; defaults to account ID<br/>  })</pre> | <pre>{<br/>  "data_actions": [<br/>    "Microsoft.DocumentDB/databaseAccounts/readMetadata",<br/>    "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery",<br/>    "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed",<br/>    "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read"<br/>  ],<br/>  "name": "DataReader",<br/>  "type": "CustomRole"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | role definition resource ID |
| <a name="output_name"></a> [name](#output\_name) | role definition name |
<!-- END_TF_DOCS -->
