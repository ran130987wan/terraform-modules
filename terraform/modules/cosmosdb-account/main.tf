##############################################################################
# Azure Cosmos DB Account Module
#
# This module creates and configures an Azure Cosmos DB account with support
# for multiple APIs (SQL, MongoDB, Cassandra, Gremlin, Table).
#
# Features:
# - Multi-region geo-replication
# - Automatic failover
# - Multiple consistency levels
# - Serverless and provisioned throughput modes
# - Backup policies (Periodic and Continuous)
# - Free tier support
##############################################################################

resource "azurerm_cosmosdb_account" "this" {
  # Basic account configuration
  name                       = var.cosmosdb.name
  location                   = var.cosmosdb.location        # Primary region
  resource_group_name        = var.cosmosdb.resource_group_name
  offer_type                 = var.cosmosdb.offer_type      # Always "Standard"
  kind                       = var.cosmosdb.kind            # GlobalDocumentDB, MongoDB, etc.
  automatic_failover_enabled = try(var.cosmosdb.automatic_failover_enabled, false)

  # Consistency policy - defines read consistency guarantees
  # Levels: Strong, BoundedStaleness, Session, ConsistentPrefix, Eventual
  consistency_policy {
    consistency_level       = var.cosmosdb.consistency_level.name
    max_interval_in_seconds = var.cosmosdb.consistency_level.max_interval_in_seconds
    max_staleness_prefix    = var.cosmosdb.consistency_level.max_staleness_prefix
  }

  dynamic "capacity" {
    for_each = var.cosmosdb.capacity != null ? [1] : []
    content {
      total_throughput_limit = capacity.total_throughput_limit
    }
  }

  # Geo locations: if none provided fall back to single primary
  dynamic "geo_location" {
    for_each = length(var.cosmosdb.geo_locations) > 0 ? var.cosmosdb.geo_locations : [
      {
        location          = var.cosmosdb.location
        failover_priority = 0
        zone_redundant    = false
      }
    ]
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = try(geo_location.value.zone_redundant, false)
    }
  }

  # Capabilities blocks (e.g. EnableServerless, EnableTable)
  dynamic "capabilities" {
    for_each = var.cosmosdb.capabilities == null ? [] : var.cosmosdb.capabilities
    content {
      name = capabilities.value
    }
  }

  # Backup policy (only render if provided)
  dynamic "backup" {
    for_each = var.cosmosdb.backup_policy == null ? [] : [var.cosmosdb.backup_policy]
    content {
      type = backup.value.type
      tier = backup.value.tier == "Periodic" ? null : try(backup.value.tier, "Continuous7Days")
      # Periodic-only attributes guarded via try to avoid validation when Continuous
      interval_in_minutes = backup.value.type == "Periodic" ? try(backup.value.interval_in_minutes, null) : null
      retention_in_hours  = backup.value.type == "Periodic" ? try(backup.value.retention_in_hours, null) : null
      storage_redundancy  = try(backup.value.storage_redundancy, null)
    }
  }

  free_tier_enabled             = try(var.cosmosdb.enable_free_tier, false)
  analytical_storage_enabled    = try(var.cosmosdb.analytical_storage_enabled, false)
  public_network_access_enabled = try(var.cosmosdb.public_network_access_enabled, false)
  create_mode                   = try(var.cosmosdb.create_mode, "Default")
  ip_range_filter               = try(var.cosmosdb.ip_range_filter, [])

  tags = var.cosmosdb.tags
}
