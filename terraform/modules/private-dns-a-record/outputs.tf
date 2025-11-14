output "id" {
  description = "The ID of the Private DNS A record."
  value       = length(azurerm_private_dns_a_record.this) > 0 ? azurerm_private_dns_a_record.this[0].id : null
}

output "name" {
  description = "The name of the Private DNS A record."
  value       = length(azurerm_private_dns_a_record.this) > 0 ? azurerm_private_dns_a_record.this[0].name : null
}

output "fqdn" {
  description = "The fully qualified domain name (FQDN) of the Private DNS A record."
  value       = length(azurerm_private_dns_a_record.this) > 0 ? azurerm_private_dns_a_record.this[0].fqdn : null
}
