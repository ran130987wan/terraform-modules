output "product_ids" {
  description = "Map of product logical keys to full resource IDs."
  value       = { for k, r in azurerm_api_management_product.product : k => r.id }
}

output "product_display_names" {
  value = { for k, r in azurerm_api_management_product.product : k => r.display_name }
}
