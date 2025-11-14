# cosmosdb-sql-database

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
| [azurerm_cosmosdb_sql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmosdb_account"></a> [cosmosdb\_account](#input\_cosmosdb\_account) | Existing Cosmos DB account to attach SQL databases to (created externally or by another module). | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_database"></a> [database](#input\_database) | Cosmos DB SQL databases to create. Throughput is mutually exclusive with max\_throughput (autoscale). | <pre>object({<br/>    name           = string<br/>    throughput     = optional(number) # Manual throughput (RU/s)<br/>    max_throughput = optional(number) # Autoscale max (RU/s)<br/>  })</pre> | <pre>{<br/>  "name": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cosmos DB SQL database |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cosmos DB SQL database |
<!-- END_TF_DOCS -->
