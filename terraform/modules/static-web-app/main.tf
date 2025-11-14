##############################################################################
# Azure Static Web App Module
#
# This module creates an Azure Static Web App for hosting static websites
# and SPAs (Single Page Applications) with built-in CI/CD integration.
#
# Features:
# - Free and Standard SKU tiers
# - Automatic deployment from GitHub/Azure DevOps
# - Built-in staging environments
# - Managed identity support
# - Basic authentication for preview environments
# - Custom domains and SSL
##############################################################################

resource "azurerm_static_web_app" "static_webapp" {
  name                = var.staticwebapp.name
  resource_group_name = var.staticwebapp.resource_group_name
  location            = var.staticwebapp.location
  tags                = var.staticwebapp.tags

  # Configuration options
  configuration_file_changes_enabled = var.staticwebapp.configuration_file_changes_enabled # Allow config changes
  preview_environments_enabled       = var.staticwebapp.preview_environments_enabled       # Enable PR environments
  public_network_access_enabled      = var.staticwebapp.public_network_access_enabled      # Public access control
  sku_tier                           = var.staticwebapp.sku_tier                           # Free or Standard
  sku_size                           = var.staticwebapp.sku_size                           # Free or Standard
  app_settings                       = var.staticwebapp.app_settings                       # Environment variables

  # Optional basic authentication for preview environments
  dynamic "basic_auth" {
    for_each = var.staticwebapp.basic_auth_enabled ? ["basic_auth"] : []

    content {
      environments = var.basic_auth.environments # Which environments require auth
      password     = var.basic_auth.password     # Basic auth password
    }
  }

  # Managed identity configuration
  dynamic "identity" {
    for_each = var.staticwebapp.identity == null ? [] : [1]

    content {
      type = var.staticwebapp.identity.type # SystemAssigned or UserAssigned
    }
  }

  # Ignore app_settings changes to allow runtime configuration
  lifecycle {
    ignore_changes = [app_settings]
  }
}
