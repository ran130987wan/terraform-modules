output "name" {
  description = "The name of the static web app"
  value       = azurerm_static_web_app.static_webapp.name
}

output "id" {
  description = "The ID of the static web app"
  value       = azurerm_static_web_app.static_webapp.id
}

output "resource_uri" {
  description = "The default hostname of the static web app"
  value       = azurerm_static_web_app.static_webapp.default_host_name
}
