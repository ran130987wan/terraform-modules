output "id" {
  description = "VPN Gateway resource ID."
  value       = azurerm_virtual_network_gateway.this.id
}

output "name" {
  description = "VPN Gateway name."
  value       = azurerm_virtual_network_gateway.this.name
}
