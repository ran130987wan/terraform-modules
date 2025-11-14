resource "azurerm_private_dns_resolver" "this" {
  name                = var.dns_resolver.name
  location            = var.dns_resolver.location
  resource_group_name = var.dns_resolver.resource_group_name
  virtual_network_id  = var.dns_resolver.virtual_network_id
  tags                = var.dns_resolver.tags
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name                    = "inbound-endpoint"
  location                = azurerm_private_dns_resolver.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = var.dns_resolver.inbound_subnet_id
  }
  tags = var.dns_resolver.tags
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = "outbound-endpoint"
  location                = azurerm_private_dns_resolver.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.dns_resolver.outbound_subnet_id
  tags                    = var.dns_resolver.tags
}

resource "azurerm_virtual_network_dns_servers" "this" {
  virtual_network_id = var.dns_resolver.virtual_network_id
  dns_servers        = [azurerm_private_dns_resolver_inbound_endpoint.this.ip_configurations[0].private_ip_address]
}
