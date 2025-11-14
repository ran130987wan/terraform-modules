##############################################################################
# Azure Container Registry (ACR) Module - Outputs
#
# These outputs expose key attributes of the created ACR instance for use
# by other modules or for reference in the root configuration.
##############################################################################

output "name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "login_server" {
  description = "The login server of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "resource_group_name" {
  description = "The resource group name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.resource_group_name
}
