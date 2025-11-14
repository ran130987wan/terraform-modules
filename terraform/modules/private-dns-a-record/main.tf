resource "azurerm_private_dns_a_record" "this" {
  count               = var.private_dns_a_record.enabled && var.private_dns_a_record.name != "" ? 1 : 0
  name                = var.private_dns_a_record.name
  zone_name           = var.private_dns_a_record.zone_name
  resource_group_name = var.private_dns_a_record.resource_group_name
  ttl                 = var.private_dns_a_record.ttl
  records             = var.private_dns_a_record.records
  tags                = var.private_dns_a_record.tags
}
