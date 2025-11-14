resource "azurerm_private_dns_zone" "this" {
  name                = var.dns_zone.name
  resource_group_name = var.dns_zone.resource_group_name
  tags                = var.dns_zone.tags
  dynamic "soa_record" {
    for_each = var.dns_zone.soa_record == null ? [] : [var.dns_zone.soa_record]
    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
    }
  }
}
