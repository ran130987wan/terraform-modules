resource "azurerm_cosmosdb_sql_role_definition" "this" {
  name                = var.role_definition.name
  resource_group_name = var.cosmosdb_account.resource_group_name
  account_name        = var.cosmosdb_account.name
  type                = var.role_definition.type
  assignable_scopes   = var.role_definition.assignable_scopes

  permissions {
    data_actions = var.role_definition.data_actions
  }
}
