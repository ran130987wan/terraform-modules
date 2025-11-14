##############################################################################
# Azure VPN Gateway Module
#
# This module creates an Azure Virtual Network Gateway for VPN connectivity.
# Supports Point-to-Site (P2S) VPN for remote user access with Azure AD auth.
#
# Features:
# - Point-to-Site VPN with Azure AD authentication
# - Site-to-Site VPN (if configured)
# - Multiple SKU options (VpnGw1-5, Basic)
# - Route-based or Policy-based VPN
##############################################################################

resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpn_gateway.name
  location            = var.vpn_gateway.location
  resource_group_name = var.vpn_gateway.resource_group_name
  type                = var.vpn_gateway.gateway_type               # Vpn or ExpressRoute
  vpn_type            = var.vpn_gateway.vpn_type                   # RouteBased or PolicyBased
  sku                 = var.vpn_gateway.gateway_sku                # VpnGw1, VpnGw2, etc.

  # Gateway IP configuration
  ip_configuration {
    name                          = "${var.vpn_gateway.name}-ipconfig"
    public_ip_address_id          = var.vpn_gateway.public_ip_id                # Public IP for gateway
    private_ip_address_allocation = var.vpn_gateway.private_ip_address_allocation # Dynamic or Static
    subnet_id                     = var.vpn_gateway.gateway_subnet_id            # GatewaySubnet
  }

  # Point-to-Site VPN client configuration with Azure AD authentication
  vpn_client_configuration {
    address_space        = var.vpn_gateway.vpn_client_address_pool # Client IP pool (e.g., ["172.16.0.0/24"])
    aad_tenant           = var.vpn_gateway.aad_tenant              # Azure AD tenant URL
    aad_audience         = var.vpn_gateway.aad_audience            # Azure VPN application ID
    aad_issuer           = var.vpn_gateway.aad_issuer              # AAD issuer URL
    vpn_client_protocols = var.vpn_gateway.vpn_client_protocols    # OpenVPN, IkeV2
  }
  tags = var.vpn_gateway.tags
}
