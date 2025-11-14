# cosmosdb-sql-container

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
| [azurerm_cosmosdb_sql_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container"></a> [container](#input\_container) | Cosmos DB SQL container configurations. | <pre>object({<br/>    name                  = string<br/>    database_name         = string<br/>    partition_key_path    = string<br/>    partition_key_version = optional(number)<br/>    default_ttl           = optional(number)       # Seconds; null/omitted means no TTL<br/>    throughput            = optional(number)       # Manual throughput (RU/s)<br/>    max_throughput        = optional(number)       # Autoscale max RU/s; if set, manual throughput ignored<br/>    unique_key_paths      = optional(list(string)) # List of paths for unique key constraint<br/>    indexing_policy = optional(object({<br/>      indexing_mode  = optional(string) # "consistent" | "lazy" | "none" (provider usually expects capitalized but we'll allow raw and not transform here)<br/>      included_paths = optional(list(string))<br/>      excluded_paths = optional(list(string))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "database_name": "",<br/>  "name": "",<br/>  "partition_key_path": ""<br/>}</pre> | no |
| <a name="input_cosmosdb_account"></a> [cosmosdb\_account](#input\_cosmosdb\_account) | Existing Cosmos DB account to attach SQL databases to (created externally or by another module). | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Cosmos DB SQL container resource ID. |
| <a name="output_name"></a> [name](#output\_name) | Cosmos DB SQL container name. |
<!-- END_TF_DOCS -->
