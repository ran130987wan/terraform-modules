resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpn_gateway.name
  location            = var.vpn_gateway.location
  resource_group_name = var.vpn_gateway.resource_group_name
  type                = var.vpn_gateway.gateway_type
  vpn_type            = var.vpn_gateway.vpn_type
  sku                 = var.vpn_gateway.gateway_sku

  ip_configuration {
    name                          = "${var.vpn_gateway.name}-ipconfig"
    public_ip_address_id          = var.vpn_gateway.public_ip_id
    private_ip_address_allocation = var.vpn_gateway.private_ip_address_allocation
    subnet_id                     = var.vpn_gateway.gateway_subnet_id
  }

  vpn_client_configuration {
    address_space        = var.vpn_gateway.vpn_client_address_pool
    aad_tenant           = var.vpn_gateway.aad_tenant
    aad_audience         = var.vpn_gateway.aad_audience
    aad_issuer           = var.vpn_gateway.aad_issuer
    vpn_client_protocols = var.vpn_gateway.vpn_client_protocols
  }
  tags = var.vpn_gateway.tags
}
