##############################################################################
# Azure NAT Gateway Module
#
# This module creates an Azure NAT Gateway to provide outbound internet
# connectivity for private subnets using a static public IP.
#
# Features:
# - Outbound internet access for private resources
# - Static public IP for predictable outbound addresses
# - High availability and scalability
# - Configurable idle timeout
##############################################################################

resource "azurerm_nat_gateway" "nat" {
  name                    = var.nat_gateway.name
  location                = var.nat_gateway.location
  resource_group_name     = var.nat_gateway.resource_group_name
  sku_name                = var.nat_gateway.sku             # Standard SKU
  idle_timeout_in_minutes = 10                             # TCP idle timeout (4-120 minutes)
  tags                    = var.nat_gateway.tags
}
