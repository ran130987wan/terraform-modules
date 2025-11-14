output "id" {
  description = "The fully qualified ID of the role definition."
  value       = azurerm_role_definition.this.id
}

output "name" {
  description = "The name of the role definition."
  value       = azurerm_role_definition.this.name
}

output "role_definition_id" {
  description = "The GUID of the role definition (role_definition_id)."
  value       = azurerm_role_definition.this.role_definition_id
}

