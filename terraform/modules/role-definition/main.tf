locals {
  assignable_scopes = try(var.role_definition.assignable_scopes, [var.role_definition.scope])
}

resource "azurerm_role_definition" "this" {
  name               = var.role_definition.name
  scope              = var.role_definition.scope
  description        = try(var.role_definition.description, "")
  role_definition_id = try(var.role_definition.role_definition_id, null)

  assignable_scopes = local.assignable_scopes

  dynamic "permissions" {
    for_each = var.role_definition.permissions
    content {
      actions          = try(permissions.value.actions, [])
      not_actions      = try(permissions.value.not_actions, [])
      data_actions     = try(permissions.value.data_actions, [])
      not_data_actions = try(permissions.value.not_data_actions, [])
    }
  }
}
