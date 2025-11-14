resource "azurerm_private_endpoint" "this" {
  name                = var.private_endpoint.name
  location            = var.private_endpoint.location
  resource_group_name = var.private_endpoint.resource_group_name
  subnet_id           = var.private_endpoint.subnet_id
  tags                = var.private_endpoint.tags

  private_service_connection {
    name                           = var.private_endpoint.private_service_connection.name
    private_connection_resource_id = var.private_endpoint.private_service_connection.private_connection_resource_id
    is_manual_connection           = var.private_endpoint.private_service_connection.is_manual_connection
    subresource_names              = var.private_endpoint.private_service_connection.subresource_names
    request_message                = try(var.private_endpoint.private_service_connection.request_message, null)
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_endpoint.private_dns_zone_group == null ? [] : [var.private_endpoint.private_dns_zone_group]
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }
}
