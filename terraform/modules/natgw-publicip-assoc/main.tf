resource "azurerm_nat_gateway_public_ip_association" "public_ip_natgw" {
  nat_gateway_id       = var.natgw_public_ip_assoc.nat_gateway_id
  public_ip_address_id = var.natgw_public_ip_assoc.public_ip_id
}