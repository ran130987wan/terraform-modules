##############################################################################
# Azure Private DNS A Record Module
#
# This module creates an A record in an Azure Private DNS Zone for mapping
# hostnames to private IP addresses within your virtual networks.
#
# Use cases:
# - Custom DNS records for private endpoints
# - Internal service discovery
# - VM hostname resolution
##############################################################################

resource "azurerm_private_dns_a_record" "this" {
  count               = var.private_dns_a_record.enabled && var.private_dns_a_record.name != "" ? 1 : 0
  name                = var.private_dns_a_record.name                # Hostname (e.g., "myapp")
  zone_name           = var.private_dns_a_record.zone_name           # Private DNS zone name
  resource_group_name = var.private_dns_a_record.resource_group_name
  ttl                 = var.private_dns_a_record.ttl                 # Time-to-live in seconds
  records             = var.private_dns_a_record.records             # List of IPv4 addresses
  tags                = var.private_dns_a_record.tags
}
