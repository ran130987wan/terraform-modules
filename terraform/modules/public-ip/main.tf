##############################################################################
# Azure Public IP Address Module
#
# This module creates a public IP address for use with load balancers,
# NAT gateways, VPN gateways, or VM network interfaces.
#
# Features:
# - Static or Dynamic allocation
# - Standard or Basic SKU
# - Zone redundancy support
# - DDoS protection
# - Custom DNS labels
##############################################################################

resource "azurerm_public_ip" "this" {
  name                = var.public_ip.name
  resource_group_name = var.public_ip.resource_group_name
  location            = var.public_ip.location

  # Allocation configuration
  allocation_method = var.public_ip.allocation_method # Static or Dynamic
  sku               = var.public_ip.sku               # Standard or Basic
  sku_tier          = try(var.public_ip.sku_tier, null) # Regional or Global
  ip_version        = try(var.public_ip.ip_version, null) # IPv4 or IPv6
  zones             = try(var.public_ip.zones, null)   # Availability zones

  # Optional settings
  idle_timeout_in_minutes = try(var.public_ip.idle_timeout_in_minutes, null) # TCP idle timeout (4-30 min)
  domain_name_label       = try(var.public_ip.domain_name_label, null)       # DNS label prefix
  reverse_fqdn            = try(var.public_ip.reverse_fqdn, null)             # Reverse DNS
  ddos_protection_mode    = try(var.public_ip.ddos_protection_mode, null)    # VirtualNetworkInherited, Enabled, Disabled

  tags = try(var.public_ip.tags, {})
}
