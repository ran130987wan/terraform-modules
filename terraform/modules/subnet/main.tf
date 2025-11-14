##############################################################################
# Azure Subnet Module
#
# This module creates one or more subnets within an Azure Virtual Network.
# Subnets segment the VNet into smaller networks for resource isolation.
#
# Features:
# - Service endpoints for Azure services (Storage, SQL, etc.)
# - Subnet delegation for specific services (AKS, App Service, etc.)
# - Private Link service network policies
# - Multiple subnets via for_each
##############################################################################

resource "azurerm_subnet" "this" {
  for_each = { for s in var.subnets : s.name => s } # Create multiple subnets

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes # CIDR blocks within VNet range

  # Private Link service network policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_disabled ? false : null

  # Service endpoints for direct access to Azure services
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
