##############################################################################
# Azure Managed Identity Module
#
# This module creates a user-assigned managed identity that can be used by
# Azure resources to authenticate to other Azure services without storing
# credentials in code.
#
# Use cases:
# - AKS cluster identity
# - VM authentication to Key Vault, Storage, etc.
# - App Service authentication
# - Function App authentication
##############################################################################

resource "azurerm_user_assigned_identity" "umi" {
  name                = var.managed_identity.umi_name # Identity name
  location            = var.managed_identity.location # Azure region
  resource_group_name = var.managed_identity.resource_group_name
  tags                = var.managed_identity.tags
}