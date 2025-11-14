##############################################################################
# Azure Custom Role Definition Module
#
# This module creates a custom Azure RBAC role definition with specific
# permissions. Custom roles enable fine-grained access control beyond
# built-in roles.
#
# Use cases:
# - Least-privilege access policies
# - Organization-specific roles
# - Compliance requirements
##############################################################################

locals {
  # Use provided assignable scopes or default to the role's scope
  assignable_scopes = try(var.role_definition.assignable_scopes, [var.role_definition.scope])
}

resource "azurerm_role_definition" "this" {
  name               = var.role_definition.name
  scope              = var.role_definition.scope                           # Where role can be assigned
  description        = try(var.role_definition.description, "")
  role_definition_id = try(var.role_definition.role_definition_id, null)  # Optional custom GUID

  assignable_scopes = local.assignable_scopes # Scopes where role can be assigned

  # Define permissions for the role
  dynamic "permissions" {
    for_each = var.role_definition.permissions
    content {
      actions          = try(permissions.value.actions, [])          # Allowed management operations
      not_actions      = try(permissions.value.not_actions, [])      # Denied management operations
      data_actions     = try(permissions.value.data_actions, [])     # Allowed data operations
      not_data_actions = try(permissions.value.not_data_actions, []) # Denied data operations
    }
  }
}
