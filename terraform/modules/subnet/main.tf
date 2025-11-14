resource "azurerm_subnet" "this" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_disabled ? false : null

  service_endpoints = length(lookup(each.value, "service_endpoints", [])) > 0 ? each.value.service_endpoints : null

  dynamic "delegation" {
    for_each = lookup(each.value, "delegations", [])
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  lifecycle {
    ignore_changes = [service_endpoints]
  }
}
