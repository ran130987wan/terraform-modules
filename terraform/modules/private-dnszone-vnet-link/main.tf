##############################################################################
# Azure Private DNS Zone VNet Link Module
#
# This module links a Private DNS Zone to a Virtual Network, enabling
# resources in the VNet to resolve names in the private DNS zone.
#
# Features:
# - Enable name resolution for private endpoints
# - Optional auto-registration of VNet resources
# - Multiple VNets can link to same zone
##############################################################################

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = var.dns_zone_vnet_link.name
  resource_group_name   = var.dns_zone_vnet_link.resource_group_name
  private_dns_zone_name = var.dns_zone_vnet_link.private_dns_zone_name # Name of the private DNS zone
  virtual_network_id    = var.dns_zone_vnet_link.virtual_network_id    # VNet resource ID
  registration_enabled  = var.dns_zone_vnet_link.registration_enabled  # Auto-register VM hostnames
  resolution_policy     = var.dns_zone_vnet_link.resolution_policy     # Default or NxDomain
  tags                  = var.dns_zone_vnet_link.tags
  depends_on            = [time_sleep.wait]
}

# Wait to avoid race conditions during zone creation
resource "time_sleep" "wait" {
  create_duration = "30s"
}
