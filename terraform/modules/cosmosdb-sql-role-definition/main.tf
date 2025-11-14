##############################################################################
# Azure Cosmos DB SQL Role Definition Module
#
# This module creates a custom RBAC role definition for Cosmos DB data plane
# operations. Unlike Azure RBAC, these roles control access to data operations.
#
# Use cases:
# - Custom read/write permissions for applications
# - Granular access control for data operations
# - Integration with managed identities
##############################################################################

resource "azurerm_cosmosdb_sql_role_definition" "this" {
  name                = var.role_definition.name
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name
  type                = var.role_definition.type            # CustomRole or BuiltInRole
  assignable_scopes   = var.role_definition.assignable_scopes # Scopes where role can be assigned

  # Data actions define what operations are allowed
  permissions {
    data_actions = var.role_definition.data_actions # e.g., ["Microsoft.DocumentDB/databaseAccounts/readMetadata"]
  }
}
