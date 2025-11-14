output "id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}
output "name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}
output "address_space" {
  description = "Address space of the VNet"
  value       = azurerm_virtual_network.vnet.address_space
}
