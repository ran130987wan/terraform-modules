locals {
  identity_type = try(var.apim.identity_type, null)
  identity_ids  = try(var.apim.identity_ids, [])
  vnet_type     = try(var.apim.virtual_network_type, null)
  vnet_subnet   = try(var.apim.virtual_network_subnet_id, null)
  protocols     = try(var.apim.protocols, ["http", "https"])
}

resource "azurerm_api_management" "apim" {
  name                = var.apim.name
  location            = var.apim.location
  resource_group_name = var.apim.resource_group_name
  publisher_email     = var.apim.publisher_email
  publisher_name      = var.apim.publisher_name
  sku_name            = var.apim.sku_name
  tags                = try(var.apim.tags, {})

  public_network_access_enabled = var.apim.public_network_access == "Enabled" ? true : false
  gateway_disabled              = try(var.apim.gateway_disabled, false)
  notification_sender_email     = try(var.apim.notification_sender_email, null)
  client_certificate_enabled    = try(var.apim.enable_client_certificate, false)
  min_api_version               = var.apim.min_api_version
  zones                         = try(var.apim.zones, [1])

  protocols {
    http2_enabled = contains(local.protocols, "http2")
  }

  # VNET
  dynamic "virtual_network_configuration" {
    for_each = (local.vnet_type != null && local.vnet_subnet != null) ? [1] : []
    content {
      subnet_id = local.vnet_subnet
    }
  }

  virtual_network_type = local.vnet_type == null ? "None" : local.vnet_type

  dynamic "identity" {
    for_each = local.identity_type != null ? [local.identity_type] : []
    content {
      type         = local.identity_type
      identity_ids = local.identity_ids
    }
  }

  dynamic "additional_location" {
    for_each = try(var.apim.additional_locations, [])
    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      gateway_disabled     = try(additional_location.value.gateway_disabled, false)
      zones                = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id

      dynamic "virtual_network_configuration" {
        for_each = local.vnet_type != "None" ? additional_location.value.subnet_id[*] : []
        content {
          subnet_id = virtual_network_configuration.value
        }
      }
    }
  }
}
