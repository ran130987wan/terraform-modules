##############################################################################
# Azure Virtual Network (VNet) Module
#
# This module creates an Azure Virtual Network - the fundamental building
# block for private networking in Azure.
#
# Features:
# - Custom address spaces (RFC 1918 recommended)
# - Optional DDoS Protection Standard
# - Support for multiple subnets (created via subnet module)
# - Network peering support
##############################################################################

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  address_space       = var.vnet.address_space # CIDR blocks (e.g., ["10.0.0.0/16"])
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
  tags                = var.vnet.tags

  # Optional DDoS Protection Standard (requires separate DDoS plan resource)
  dynamic "ddos_protection_plan" {
    for_each = var.vnet.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.vnet.ddos_protection_plan_id
      enable = true
    }
  }
}
