resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = var.dns_zone_vnet_link.name
  resource_group_name   = var.dns_zone_vnet_link.resource_group_name
  private_dns_zone_name = var.dns_zone_vnet_link.private_dns_zone_name
  virtual_network_id    = var.dns_zone_vnet_link.virtual_network_id
  registration_enabled  = var.dns_zone_vnet_link.registration_enabled
  resolution_policy     = var.dns_zone_vnet_link.resolution_policy
  tags                  = var.dns_zone_vnet_link.tags
  depends_on            = [time_sleep.wait]
}

resource "time_sleep" "wait" {
  create_duration = "30s"
}
