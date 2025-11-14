output "id" {
  description = "The ID of the Private Endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "The name of the Private Endpoint."
  value       = azurerm_private_endpoint.this.name
}

output "private_endpoint_serviceconnection_details" {
  description = "The private service connection details of the Private Endpoint."
  value       = azurerm_private_endpoint.this.private_service_connection
}
