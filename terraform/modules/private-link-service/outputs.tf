output "id" {
  description = "The ID of the Private Link Service."
  value       = azurerm_private_link_service.this.id
}

output "name" {
  description = "The name of the Private Link Service."
  value       = azurerm_private_link_service.this.name
}

output "alias" {
  description = "The alias of the Private Link Service."
  value       = azurerm_private_link_service.this.alias
}
