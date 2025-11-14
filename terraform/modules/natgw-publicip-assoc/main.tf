##############################################################################
# NAT Gateway Public IP Association Module
#
# This module associates a public IP address with a NAT Gateway, enabling
# outbound internet connectivity for private subnets.
#
# Note: A NAT Gateway can have multiple public IPs for increased capacity.
##############################################################################

resource "azurerm_nat_gateway_public_ip_association" "public_ip_natgw" {
  nat_gateway_id       = var.natgw_public_ip_assoc.nat_gateway_id   # NAT Gateway resource ID
  public_ip_address_id = var.natgw_public_ip_assoc.public_ip_id    # Public IP resource ID
}