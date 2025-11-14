resource "azurerm_static_web_app" "static_webapp" {
  name                = var.staticwebapp.name
  resource_group_name = var.staticwebapp.resource_group_name
  location            = var.staticwebapp.location
  tags                = var.staticwebapp.tags

  configuration_file_changes_enabled = var.staticwebapp.configuration_file_changes_enabled
  preview_environments_enabled       = var.staticwebapp.preview_environments_enabled
  public_network_access_enabled      = var.staticwebapp.public_network_access_enabled
  sku_tier                           = var.staticwebapp.sku_tier
  sku_size                           = var.staticwebapp.sku_size
  app_settings                       = var.staticwebapp.app_settings

  dynamic "basic_auth" {
    for_each = var.staticwebapp.basic_auth_enabled ? ["basic_auth"] : []

    content {
      environments = var.basic_auth.environments
      password     = var.basic_auth.password
    }
  }

  dynamic "identity" {
    for_each = var.staticwebapp.identity == null ? [] : [1]

    content {
      type = var.staticwebapp.identity.type
    }
  }

  lifecycle {
    ignore_changes = [app_settings]
  }
}
