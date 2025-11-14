resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  address_space       = var.vnet.address_space
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
  tags                = var.vnet.tags

  dynamic "ddos_protection_plan" {
    for_each = var.vnet.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.vnet.ddos_protection_plan_id
      enable = true
    }
  }
}
