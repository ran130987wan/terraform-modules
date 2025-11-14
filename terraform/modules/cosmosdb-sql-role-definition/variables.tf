variable "cosmosdb_account" {
  description = "Existing Cosmos DB account to attach SQL databases to (created externally or by another module)."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "role_definition" {
  description = "Cosmos DB SQL role definitions. Each value configures a role definition resource."
  type = object({
    name              = string # Role name (display)
    type              = optional(string, "CustomRole")
    data_actions      = list(string)           # Allowed data actions
    not_data_actions  = optional(list(string)) # Explicitly denied data actions
    assignable_scopes = optional(list(string)) # Override scopes; defaults to account ID
  })
  default = {
    name = "DataReader"
    type = "CustomRole"
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read"
    ]
  }
}

