##############################################################################
# Azure Resource Group Module
#
# This module creates one or more Azure Resource Groups - logical containers
# for organizing and managing Azure resources.
#
# Features:
# - Multiple resource groups via for_each
# - Optional CanNotDelete locks for protection
# - Tagging support for organization and billing
##############################################################################

# Create resource groups
resource "azurerm_resource_group" "this" {
  for_each = { for rg in var.resource_groups : rg.name => rg }

  name     = each.value.name     # Resource group name (unique within subscription)
  location = each.value.location # Azure region
  tags     = each.value.tags
}

# Optional management lock to prevent accidental deletion
resource "azurerm_management_lock" "rg_lock" {
  for_each = {
    for rg in var.resource_groups :
    rg.name => rg if rg.locks # Only create locks where locks = true
  }

  name       = "${each.value.name}-lock"
  scope      = azurerm_resource_group.this[each.key].id
  lock_level = "CanNotDelete" # Prevents deletion but allows modifications
  notes      = "Resource group lock enabled via Terraform"
}
