##############################################################################
# Azure Private DNS Resolver Module
#
# This module creates an Azure Private DNS Resolver with inbound and outbound
# endpoints for DNS resolution between Azure and on-premises networks.
#
# Features:
# - Inbound endpoint for on-premises to Azure DNS queries
# - Outbound endpoint for Azure to on-premises DNS queries
# - Automatic VNet DNS server configuration
# - Replaces need for custom DNS VMs
##############################################################################

# Main DNS Resolver resource
resource "azurerm_private_dns_resolver" "this" {
  name                = var.dns_resolver.name
  location            = var.dns_resolver.location
  resource_group_name = var.dns_resolver.resource_group_name
  virtual_network_id  = var.dns_resolver.virtual_network_id # VNet where resolver is deployed
  tags                = var.dns_resolver.tags
}

# Inbound endpoint - allows on-premises to query Azure Private DNS
resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name                    = "inbound-endpoint"
  location                = azurerm_private_dns_resolver.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  
  # IP configuration in dedicated subnet
  ip_configurations {
    private_ip_allocation_method = "Dynamic" # Or Static with specific IP
    subnet_id                    = var.dns_resolver.inbound_subnet_id
  }
  tags = var.dns_resolver.tags
}

# Outbound endpoint - allows Azure to forward queries to on-premises DNS
resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = "outbound-endpoint"
  location                = azurerm_private_dns_resolver.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.dns_resolver.outbound_subnet_id # Dedicated subnet required
  tags                    = var.dns_resolver.tags
}

# Configure VNet to use the inbound endpoint as DNS server
resource "azurerm_virtual_network_dns_servers" "this" {
  virtual_network_id = var.dns_resolver.virtual_network_id
  dns_servers        = [azurerm_private_dns_resolver_inbound_endpoint.this.ip_configurations[0].private_ip_address]
}
