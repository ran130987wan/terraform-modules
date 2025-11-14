resource "azurerm_public_ip" "this" {
  name                = var.public_ip.name
  resource_group_name = var.public_ip.resource_group_name
  location            = var.public_ip.location

  allocation_method = var.public_ip.allocation_method
  sku               = var.public_ip.sku
  sku_tier          = try(var.public_ip.sku_tier, null)
  ip_version        = try(var.public_ip.ip_version, null)
  zones             = try(var.public_ip.zones, null)

  idle_timeout_in_minutes = try(var.public_ip.idle_timeout_in_minutes, null)
  domain_name_label       = try(var.public_ip.domain_name_label, null)
  reverse_fqdn            = try(var.public_ip.reverse_fqdn, null)
  ddos_protection_mode    = try(var.public_ip.ddos_protection_mode, null)

  tags = try(var.public_ip.tags, {})
}
