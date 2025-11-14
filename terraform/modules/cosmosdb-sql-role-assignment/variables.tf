variable "cosmosdb_account" {
  description = "Existing Cosmos DB account to attach SQL databases to (created externally or by another module)."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "role_assignment" {
  description = "Cosmos DB SQL role assignments. Each value configures a role assignment resource."
  type = object({
    principal_id       = string # Object ID of the principal (user, group, service principal) to assign the role to
    scope              = string # Override scope; defaults to account ID or module-level scope
    role_definition_id = string # Override role definition ID; defaults to module-level role_definition_id
  })
  default = {
    principal_id       = ""
    scope              = ""
    role_definition_id = ""
  }
}
