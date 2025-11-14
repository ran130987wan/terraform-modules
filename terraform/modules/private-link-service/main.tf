resource "azurerm_private_link_service" "this" {
  name                                        = var.private_link_service.name
  location                                    = var.private_link_service.location
  resource_group_name                         = var.private_link_service.resource_group_name
  load_balancer_frontend_ip_configuration_ids = var.private_link_service.load_balancer_frontend_ip_configuration_ids
  auto_approval_subscription_ids              = var.private_link_service.auto_approval_subscription_ids
  visibility_subscription_ids                 = var.private_link_service.visibility_subscription_ids
  fqdns                                       = var.private_link_service.fqdns
  tags                                        = var.private_link_service.tags


  dynamic "nat_ip_configuration" {
    for_each = var.private_link_service.nat_ip_configuration == null ? [] : [var.private_link_service.nat_ip_configuration]
    content {
      name                       = nat_ip_configuration.value.name
      subnet_id                  = nat_ip_configuration.value.subnet_id
      private_ip_address         = try(nat_ip_configuration.value.private_ip_address, null)
      private_ip_address_version = nat_ip_configuration.value.private_ip_address_version
      primary                    = nat_ip_configuration.value.primary
    }
  }
}
