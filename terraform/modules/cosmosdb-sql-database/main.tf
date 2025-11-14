resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.database.name
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name

  # Throughput only set when autoscale not used
  throughput = try(var.database.max_throughput, null) != null ? null : try(var.database.throughput, null)

  dynamic "autoscale_settings" {
    for_each = try(var.database.max_throughput, null) != null ? [var.database.max_throughput] : []
    content {
      max_throughput = autoscale_settings.value
    }
  }
}
