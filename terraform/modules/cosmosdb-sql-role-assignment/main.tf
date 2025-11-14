resource "random_uuid" "assignment" {}

resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  name                = random_uuid.assignment.result
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name
  role_definition_id  = var.role_assignment.role_definition_id
  principal_id        = var.role_assignment.principal_id
  scope               = var.role_assignment.scope
}
