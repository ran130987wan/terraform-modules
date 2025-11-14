##############################################################################
# Azure Cosmos DB SQL Role Assignment Module
#
# This module assigns a Cosmos DB RBAC role to a principal (managed identity,
# service principal) at a specific scope (account, database, or container).
#
# Use case: Grant managed identities access to Cosmos DB without keys.
##############################################################################

# Generate unique ID for the role assignment
resource "random_uuid" "assignment" {}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  name                = random_uuid.assignment.result         # Unique assignment ID
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name
  role_definition_id  = var.role_assignment.role_definition_id # Role definition resource ID
  principal_id        = var.role_assignment.principal_id       # Object ID of principal
  scope               = var.role_assignment.scope              # Assignment scope (account/db/container)
}
