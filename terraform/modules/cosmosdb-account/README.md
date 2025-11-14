# cosmosdb-account

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
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmosdb"></a> [cosmosdb](#input\_cosmosdb) | Configuration object for the Cosmos DB module. Optional attributes allow advanced configuration without forcing all callers to specify them. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>    location            = string<br/>    offer_type          = string<br/>    kind                = string<br/>    tags                = map(string)<br/><br/>    # Advanced / optional flags<br/>    enable_free_tier                = optional(bool)<br/>    analytical_storage_enabled      = optional(bool)<br/>    enable_multiple_write_locations = optional(bool)<br/>    public_network_access_enabled   = optional(bool)<br/>    ip_range_filter                 = optional(list(string))<br/>    create_mode                     = optional(string)<br/><br/>    # Consistency policy<br/>    consistency_level = object({<br/>      name                    = string<br/>      max_interval_in_seconds = optional(number, null)<br/>      max_staleness_prefix    = optional(number, null)<br/>    })<br/><br/>    capacity = optional(object({<br/>      total_throughput_limit = number<br/>    }))<br/><br/>    # Capabilities (e.g. "EnableServerless", "EnableTable", "EnableGremlin")<br/>    capabilities = optional(list(string))<br/><br/>    # Multiple geo locations (first must have failover_priority 0)<br/>    geo_locations = optional(list(object({<br/>      location          = string<br/>      failover_priority = number<br/>      zone_redundant    = optional(bool)<br/>    })))<br/><br/>    # Backup policy (type = "Continuous" or "Periodic")<br/>    backup_policy = optional(object({<br/>      type                = string<br/>      tier                = optional(string) # E.g. "Continuous7Days", "Continuous30Days"<br/>      interval_in_minutes = optional(number) # Periodic only<br/>      retention_in_hours  = optional(number) # Periodic only<br/>      storage_redundancy  = optional(string) # E.g. "Geo", "Zone", "Local"<br/>    }))<br/>  })</pre> | <pre>{<br/>  "analytical_storage_enabled": false,<br/>  "backup_policy": null,<br/>  "bounded_staleness": null,<br/>  "capabilities": [],<br/>  "consistency_level": {<br/>    "name": "Session"<br/>  },<br/>  "enable_free_tier": false,<br/>  "enable_multiple_write_locations": false,<br/>  "geo_locations": [],<br/>  "ip_range_filter": null,<br/>  "kind": "",<br/>  "location": "",<br/>  "name": "",<br/>  "offer_type": "",<br/>  "public_network_access_enabled": true,<br/>  "resource_group_name": "",<br/>  "tags": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmosdb_account_endpoint"></a> [cosmosdb\_account\_endpoint](#output\_cosmosdb\_account\_endpoint) | The endpoint URI of the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_key"></a> [cosmosdb\_account\_primary\_key](#output\_cosmosdb\_account\_primary\_key) | The primary key for the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_mongodb_connection_string"></a> [cosmosdb\_account\_primary\_mongodb\_connection\_string](#output\_cosmosdb\_account\_primary\_mongodb\_connection\_string) | The primary MongoDB connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_readonly_key"></a> [cosmosdb\_account\_primary\_readonly\_key](#output\_cosmosdb\_account\_primary\_readonly\_key) | The primary read-only key for the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_readonly_mongodb_connection_string"></a> [cosmosdb\_account\_primary\_readonly\_mongodb\_connection\_string](#output\_cosmosdb\_account\_primary\_readonly\_mongodb\_connection\_string) | The primary read-only MongoDB connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_readonly_sql_connection_string"></a> [cosmosdb\_account\_primary\_readonly\_sql\_connection\_string](#output\_cosmosdb\_account\_primary\_readonly\_sql\_connection\_string) | The primary read-only SQL connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_primary_sql_connection_string"></a> [cosmosdb\_account\_primary\_sql\_connection\_string](#output\_cosmosdb\_account\_primary\_sql\_connection\_string) | The primary SQL connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_key"></a> [cosmosdb\_account\_secondary\_key](#output\_cosmosdb\_account\_secondary\_key) | The secondary key for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_mongodb_connection_string"></a> [cosmosdb\_account\_secondary\_mongodb\_connection\_string](#output\_cosmosdb\_account\_secondary\_mongodb\_connection\_string) | The secondary MongoDB connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_readonly_key"></a> [cosmosdb\_account\_secondary\_readonly\_key](#output\_cosmosdb\_account\_secondary\_readonly\_key) | The secondary read-only key for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_readonly_mongodb_connection_string"></a> [cosmosdb\_account\_secondary\_readonly\_mongodb\_connection\_string](#output\_cosmosdb\_account\_secondary\_readonly\_mongodb\_connection\_string) | The secondary read-only MongoDB connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_readonly_sql_connection_string"></a> [cosmosdb\_account\_secondary\_readonly\_sql\_connection\_string](#output\_cosmosdb\_account\_secondary\_readonly\_sql\_connection\_string) | The secondary read-only SQL connection string for the Cosmos DB account. |
| <a name="output_cosmosdb_account_secondary_sql_connection_string"></a> [cosmosdb\_account\_secondary\_sql\_connection\_string](#output\_cosmosdb\_account\_secondary\_sql\_connection\_string) | The secondary SQL connection string for the Cosmos DB account. |
| <a name="output_id"></a> [id](#output\_id) | The id of the Cosmos DB account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cosmos DB account. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name containing the Cosmos DB account. |
<!-- END_TF_DOCS -->
