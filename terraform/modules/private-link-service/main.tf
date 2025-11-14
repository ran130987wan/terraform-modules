##############################################################################
# Azure Private Link Service Module
#
# This module creates a Private Link Service to expose your service to
# customers via private endpoints. Enables secure, private connectivity
# without exposing services to the public internet.
#
# Features:
# - Expose services behind Standard Load Balancer
# - Auto-approval for specific subscriptions
# - Visibility control
# - NAT IP configuration
##############################################################################

resource "azurerm_private_link_service" "this" {
  name                                        = var.private_link_service.name
  location                                    = var.private_link_service.location
  resource_group_name                         = var.private_link_service.resource_group_name
  load_balancer_frontend_ip_configuration_ids = var.private_link_service.load_balancer_frontend_ip_configuration_ids # Load balancer frontend IPs
  auto_approval_subscription_ids              = var.private_link_service.auto_approval_subscription_ids              # Auto-approve these subscriptions
  visibility_subscription_ids                 = var.private_link_service.visibility_subscription_ids                 # Visible to these subscriptions
  fqdns                                       = var.private_link_service.fqdns                                       # FQDNs for the service
  tags                                        = var.private_link_service.tags

  # NAT IP configuration for private link connections
  dynamic "nat_ip_configuration" {
    for_each = var.private_link_service.nat_ip_configuration == null ? [] : [var.private_link_service.nat_ip_configuration]
    content {
      name                       = nat_ip_configuration.value.name
      subnet_id                  = nat_ip_configuration.value.subnet_id                  # Subnet for NAT IPs
      private_ip_address         = try(nat_ip_configuration.value.private_ip_address, null) # Static or dynamic
      private_ip_address_version = nat_ip_configuration.value.private_ip_address_version # IPv4 or IPv6
      primary                    = nat_ip_configuration.value.primary                    # Primary configuration
    }
  }
}
