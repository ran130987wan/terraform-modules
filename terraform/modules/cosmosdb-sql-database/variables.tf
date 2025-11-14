variable "cosmosdb_account" {
  description = "Existing Cosmos DB account to attach SQL databases to (created externally or by another module)."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "database" {
  description = "Cosmos DB SQL databases to create. Throughput is mutually exclusive with max_throughput (autoscale)."
  type = object({
    name           = string
    throughput     = optional(number) # Manual throughput (RU/s)
    max_throughput = optional(number) # Autoscale max (RU/s)
  })
  default = {
    name = ""
  }
  # validation {
  #   condition     = var.databases.throughput != null && var.databases.max_throughput != null ? false : true
  #   error_message = "Specify either throughput or max_throughput for a database, not both."
  # }
}
