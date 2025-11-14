resource "azurerm_role_assignment" "this" {
  scope          = var.role_assignment.scope
  principal_id   = var.role_assignment.principal_id
  principal_type = var.role_assignment.principal_type

  # Use one of the two (name for built-ins, id for custom roles)
  role_definition_name = try(var.role_assignment.role_definition_name, null)
  role_definition_id   = try(var.role_assignment.role_definition_id, null)

  condition         = try(var.role_assignment.condition, null)
  condition_version = try(var.role_assignment.condition_version, null)

  description                      = var.role_assignment.description
  skip_service_principal_aad_check = var.role_assignment.skip_service_principal_aad_check
}
