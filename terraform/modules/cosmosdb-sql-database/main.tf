##############################################################################
# Azure Cosmos DB SQL Database Module
#
# This module creates a database within an Azure Cosmos DB account using
# the SQL API (Core API).
#
# Features:
# - Manual or autoscale throughput provisioning
# - Shared throughput across containers
# - Database-level RU/s allocation
##############################################################################

resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.database.name
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name

  # Throughput settings: use manual throughput only when autoscale is not configured
  throughput = try(var.database.max_throughput, null) != null ? null : try(var.database.throughput, null)

  # Autoscale configuration for automatic RU/s scaling
  dynamic "autoscale_settings" {
    for_each = try(var.database.max_throughput, null) != null ? [var.database.max_throughput] : []
    content {
      max_throughput = autoscale_settings.value # Maximum RU/s (minimum is 10% of max)
    }
  }
}
