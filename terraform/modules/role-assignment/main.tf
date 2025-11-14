##############################################################################
# Azure Role Assignment Module
#
# This module creates an Azure RBAC role assignment, granting a principal
# (user, group, service principal, or managed identity) a specific role
# at a given scope (subscription, resource group, or resource).
#
# Features:
# - Built-in or custom role definitions
# - Conditional access policies
# - Support for all principal types
# - Flexible scope assignment
##############################################################################

resource "azurerm_role_assignment" "this" {
  scope          = var.role_assignment.scope          # Resource ID of the scope
  principal_id   = var.role_assignment.principal_id   # Object ID of the principal
  principal_type = var.role_assignment.principal_type # User, Group, ServicePrincipal

  # Use either role name (for built-in roles) or role ID (for custom roles)
  role_definition_name = try(var.role_assignment.role_definition_name, null) # e.g., "Contributor"
  role_definition_id   = try(var.role_assignment.role_definition_id, null)   # Custom role resource ID

  # Optional conditional access
  condition         = try(var.role_assignment.condition, null)         # ABAC condition expression
  condition_version = try(var.role_assignment.condition_version, null) # Condition version (2.0)

  description                      = var.role_assignment.description
  skip_service_principal_aad_check = var.role_assignment.skip_service_principal_aad_check # Skip AAD check for SPs
}
