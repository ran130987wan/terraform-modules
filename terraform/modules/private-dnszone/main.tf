##############################################################################
# Azure Private DNS Zone Module
#
# This module creates an Azure Private DNS Zone for name resolution within
# virtual networks. Used for private endpoints and custom DNS records.
#
# Features:
# - Private name resolution within VNets
# - Integration with Azure Private Link
# - Custom SOA record configuration
# - No internet exposure
##############################################################################

resource "azurerm_private_dns_zone" "this" {
  name                = var.dns_zone.name # e.g., "privatelink.blob.core.windows.net"
  resource_group_name = var.dns_zone.resource_group_name
  tags                = var.dns_zone.tags
  
  # Optional Start of Authority (SOA) record customization
  dynamic "soa_record" {
    for_each = var.dns_zone.soa_record == null ? [] : [var.dns_zone.soa_record]
    content {
      email        = soa_record.value.email        # Administrative email
      expire_time  = soa_record.value.expire_time  # Zone expiry time (seconds)
      minimum_ttl  = soa_record.value.minimum_ttl  # Minimum TTL for negative caching
      refresh_time = soa_record.value.refresh_time # Refresh interval (seconds)
      retry_time   = soa_record.value.retry_time   # Retry interval (seconds)
      ttl          = soa_record.value.ttl          # SOA record TTL
    }
  }
}
