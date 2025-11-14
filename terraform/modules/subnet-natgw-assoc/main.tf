resource "azurerm_subnet_nat_gateway_association" "natgw_with_subnet" {
  subnet_id      = var.config.subnet_id
  nat_gateway_id = var.config.nat_gateway_id
}
