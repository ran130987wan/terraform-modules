variable "cosmosdb_account" {
  description = "Existing Cosmos DB account to attach SQL databases to (created externally or by another module)."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "container" {
  description = "Cosmos DB SQL container configurations."
  type = object({
    name                  = string
    database_name         = string
    partition_key_path    = string
    partition_key_version = optional(number)
    default_ttl           = optional(number)       # Seconds; null/omitted means no TTL
    throughput            = optional(number)       # Manual throughput (RU/s)
    max_throughput        = optional(number)       # Autoscale max RU/s; if set, manual throughput ignored
    unique_key_paths      = optional(list(string)) # List of paths for unique key constraint
    indexing_policy = optional(object({
      indexing_mode  = optional(string) # "consistent" | "lazy" | "none" (provider usually expects capitalized but we'll allow raw and not transform here)
      included_paths = optional(list(string))
      excluded_paths = optional(list(string))
    }))
  })
  default = {
    name               = ""
    database_name      = ""
    partition_key_path = ""
  }
}

