variable "cosmosdb" {
  description = "Configuration object for the Cosmos DB module. Optional attributes allow advanced configuration without forcing all callers to specify them."
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    offer_type          = string
    kind                = string
    tags                = map(string)

    # Advanced / optional flags
    enable_free_tier                = optional(bool)
    analytical_storage_enabled      = optional(bool)
    enable_multiple_write_locations = optional(bool)
    public_network_access_enabled   = optional(bool)
    ip_range_filter                 = optional(list(string))
    create_mode                     = optional(string)

    # Consistency policy
    consistency_level = object({
      name                    = string
      max_interval_in_seconds = optional(number, null)
      max_staleness_prefix    = optional(number, null)
    })

    capacity = optional(object({
      total_throughput_limit = number
    }))

    # Capabilities (e.g. "EnableServerless", "EnableTable", "EnableGremlin")
    capabilities = optional(list(string))

    # Multiple geo locations (first must have failover_priority 0)
    geo_locations = optional(list(object({
      location          = string
      failover_priority = number
      zone_redundant    = optional(bool)
    })))

    # Backup policy (type = "Continuous" or "Periodic")
    backup_policy = optional(object({
      type                = string
      tier                = optional(string) # E.g. "Continuous7Days", "Continuous30Days"
      interval_in_minutes = optional(number) # Periodic only
      retention_in_hours  = optional(number) # Periodic only
      storage_redundancy  = optional(string) # E.g. "Geo", "Zone", "Local"
    }))
  })
  default = {
    name                = ""
    resource_group_name = ""
    location            = ""
    offer_type          = ""
    kind                = ""
    consistency_level = {
      name = "Session"
    }
    tags                            = {}
    enable_free_tier                = false
    analytical_storage_enabled      = false
    enable_multiple_write_locations = false
    public_network_access_enabled   = true
    ip_range_filter                 = null
    bounded_staleness               = null
    capabilities                    = []
    geo_locations                   = []
    backup_policy                   = null
  }
}
