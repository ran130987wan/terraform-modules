
output "public_ip_id" {
  description = "The ID of the Public IP."
  value       = azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "The assigned Public IP address (may be null until provisioned if dynamic)."
  value       = azurerm_public_ip.this.ip_address
}

output "public_ip_fqdn" {
  description = "The FQDN associated with the Public IP (if DNS settings were configured)."
  value       = azurerm_public_ip.this.fqdn
}

output "public_ip_name" {
  description = "The name of the Public IP resource."
  value       = azurerm_public_ip.this.name
}

output "public_ip_location" {
  description = "Azure region of the Public IP."
  value       = azurerm_public_ip.this.location
}

output "public_ip_resource_group" {
  description = "Resource Group containing the Public IP."
  value       = azurerm_public_ip.this.resource_group_name
}

output "public_ip_allocation_method" {
  description = "Allocation method (Static or Dynamic)."
  value       = azurerm_public_ip.this.allocation_method
}

output "public_ip_sku" {
  description = "SKU of the Public IP."
  value       = azurerm_public_ip.this.sku
}

output "public_ip_version" {
  description = "IP version (IPv4 or IPv6)."
  value       = azurerm_public_ip.this.ip_version
}

output "public_ip_tags" {
  description = "Tags applied to the Public IP."
  value       = azurerm_public_ip.this.tags
}