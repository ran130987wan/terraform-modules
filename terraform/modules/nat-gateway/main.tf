resource "azurerm_nat_gateway" "nat" {
  name                    = var.nat_gateway.name
  location                = var.nat_gateway.location
  resource_group_name     = var.nat_gateway.resource_group_name
  sku_name                = var.nat_gateway.sku
  idle_timeout_in_minutes = 10
  tags                    = var.nat_gateway.tags
}
