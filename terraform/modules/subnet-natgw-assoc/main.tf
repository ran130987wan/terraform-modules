##############################################################################
# Subnet NAT Gateway Association Module
#
# This module associates a subnet with a NAT Gateway, routing all outbound
# internet traffic from the subnet through the NAT Gateway's public IP.
#
# Use case: Provide internet access to private subnets without public IPs.
##############################################################################

resource "azurerm_subnet_nat_gateway_association" "natgw_with_subnet" {
  subnet_id      = var.config.subnet_id      # Subnet resource ID
  nat_gateway_id = var.config.nat_gateway_id # NAT Gateway resource ID
}
