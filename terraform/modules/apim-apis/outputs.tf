output "api_ids" {
  description = "Map of API logical names to resource IDs."
  value       = { for k, r in azurerm_api_management_api.api : k => r.id }
}

output "api_paths" {
  description = "Map of API logical names to public paths."
  value       = { for k, r in azurerm_api_management_api.api : k => r.path }
}
