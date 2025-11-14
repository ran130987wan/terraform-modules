##############################################################################
# Azure Key Vault Module
#
# This module creates and configures an Azure Key Vault for securely storing
# and managing secrets, keys, and certificates.
#
# Features:
# - Standard and Premium SKUs (Premium includes HSM support)
# - Soft delete and purge protection
# - Network access controls
# - Access policies or RBAC authorization
# - Integration with Azure services (VMs, ARM templates)
##############################################################################

# tfsec:ignore:azure-keyvault-specify-network-acl - Network ACLs configured via dynamic block
resource "azurerm_key_vault" "this" {
  # Basic Key Vault configuration
  name                            = var.vault.name # Globally unique, 3-24 chars
  location                        = var.vault.location
  resource_group_name             = var.vault.resource_group_name
  
  # Integration with Azure services
  enabled_for_disk_encryption     = var.vault.enabled_for_disk_encryption     # Allow Azure Disk Encryption
  enabled_for_deployment          = var.vault.enabled_for_deployment          # Allow VM deployments
  enabled_for_template_deployment = var.vault.enabled_for_template_deployment # Allow ARM templates
  
  # Identity and security
  tenant_id                       = var.vault.tenant_id # Azure AD tenant ID
  soft_delete_retention_days      = var.vault.soft_delete_retention_days # 7-90 days
  purge_protection_enabled        = var.vault.purge_protection_enabled   # Prevent permanent deletion
  public_network_access_enabled   = try(var.vault.public_network_access_enabled, false)
  sku_name                        = var.vault.sku_name                   # standard or premium
  rbac_authorization_enabled      = var.vault.rbac_authorization_enabled # Use Azure RBAC instead of access policies

  dynamic "access_policy" {
    for_each = var.vault.access_policies
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id

      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }

  dynamic "network_acls" {
    for_each = var.vault.network_acls == null ? [] : [var.vault.network_acls]
    content {
      bypass                     = network_acls.value.bypass
      default_action             = try(network_acls.value.default_action, "Deny")
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  tags = var.vault.tags
}
