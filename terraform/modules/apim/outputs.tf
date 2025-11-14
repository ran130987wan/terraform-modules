output "id" {
  value       = azurerm_api_management.apim.id
  description = "The ID of the API Management instance."
}

output "name" {
  value       = azurerm_api_management.apim.name
  description = "The name of the API Management instance."
}

output "gateway_url" {
  value       = azurerm_api_management.apim.gateway_url
  description = "The gateway URL of the API Management instance."
}

output "portal_url" {
  value       = azurerm_api_management.apim.portal_url
  description = "The developer portal URL of the API Management instance."
}
