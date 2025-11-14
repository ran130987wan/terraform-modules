# tfsec:ignore:azure-keyvault-specify-network-acl
resource "azurerm_key_vault" "this" {
  name                            = var.vault.name
  location                        = var.vault.location
  resource_group_name             = var.vault.resource_group_name
  enabled_for_disk_encryption     = var.vault.enabled_for_disk_encryption
  enabled_for_deployment          = var.vault.enabled_for_deployment
  enabled_for_template_deployment = var.vault.enabled_for_template_deployment
  tenant_id                       = var.vault.tenant_id
  soft_delete_retention_days      = var.vault.soft_delete_retention_days
  purge_protection_enabled        = var.vault.purge_protection_enabled
  public_network_access_enabled   = try(var.vault.public_network_access_enabled, false)
  sku_name                        = var.vault.sku_name
  rbac_authorization_enabled      = var.vault.rbac_authorization_enabled

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
