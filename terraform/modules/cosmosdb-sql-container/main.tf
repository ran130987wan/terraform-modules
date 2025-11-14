resource "azurerm_cosmosdb_sql_container" "this" {
  name                = var.container.name
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name
  database_name       = var.container.database_name

  # Provider requires list attribute partition_key_paths
  partition_key_paths   = [var.container.partition_key_path]
  partition_key_version = try(var.container.partition_key_version, null)
  default_ttl           = try(var.container.default_ttl, null)

  # Throughput vs autoscale: if max_throughput is set, manual throughput must be null
  throughput = try(var.container.max_throughput, null) != null ? null : try(var.container.throughput, null)

  dynamic "autoscale_settings" {
    for_each = try(var.container.max_throughput, null) != null ? [var.container.max_throughput] : []
    content {
      max_throughput = autoscale_settings.value
    }
  }

  # Unique key constraint
  dynamic "unique_key" {
    for_each = try(var.container.unique_key_paths, null) != null ? [var.container.unique_key_paths] : []
    content {
      paths = unique_key.value
    }
  }

  # Indexing policy definition
  dynamic "indexing_policy" {
    for_each = try(var.container.indexing_policy, null) != null ? [var.container.indexing_policy] : []
    content {
      indexing_mode = try(indexing_policy.value.indexing_mode, "consistent")

      dynamic "included_path" {
        for_each = try(indexing_policy.value.included_paths, [])
        content {
          path = included_path.value
        }
      }

      dynamic "excluded_path" {
        for_each = try(indexing_policy.value.excluded_paths, [])
        content {
          path = excluded_path.value
        }
      }
    }
  }
}
