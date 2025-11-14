output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name."
  value       = { for name, s in azurerm_subnet.this : name => s.id }
}

output "subnet_names" {
  description = "List of subnet names created."
  value       = [for s in azurerm_subnet.this : s.name]
}

output "subnet_address_prefixes" {
  description = "Map of address prefix lists keyed by subnet name."
  value       = { for name, s in azurerm_subnet.this : name => s.address_prefixes }
}

output "subnet_resource_group_names" {
  description = "Map of resource group names keyed by subnet name."
  value       = { for name, s in azurerm_subnet.this : name => s.resource_group_name }
}

output "subnet_virtual_network_names" {
  description = "Map of virtual network names keyed by subnet name."
  value       = { for name, s in azurerm_subnet.this : name => s.virtual_network_name }
}
