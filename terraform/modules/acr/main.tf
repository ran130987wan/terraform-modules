locals {
  network_rule_set = (
    var.acr.network_rule_set != null
    ? var.acr.network_rule_set
    : {
      default_action             = "Allow"
      ip_rules                   = []
      virtual_network_subnet_ids = []
    }
  )

  georeplication_locations = (
    var.acr.georeplication_locations != null
    ? var.acr.georeplication_locations
    : []
  )
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr.name
  resource_group_name = var.acr.resource_group_name
  location            = var.acr.location
  tags                = try(var.acr.tags, {})

  sku = try(var.acr.sku, "Standard")

  admin_enabled                 = try(var.acr.admin_enabled, false)
  public_network_access_enabled = try(var.acr.public_network_access_enabled, true)
  anonymous_pull_enabled        = try(var.acr.anonymous_pull_enabled, false)
  data_endpoint_enabled         = try(var.acr.data_endpoint_enabled, false)
  zone_redundancy_enabled       = try(var.acr.zone_redundancy_enabled, false)
  export_policy_enabled         = try(var.acr.export_policy_enabled, false)
  quarantine_policy_enabled     = try(var.acr.quarantine_policy_enabled, false)

  dynamic "identity" {
    for_each = coalesce([var.acr.identity_type], []) != [] ? [var.acr.identity_type] : []
    content {
      type         = var.acr.identity_type
      identity_ids = try(var.acr.identity_ids, [])
    }
  }

  dynamic "georeplications" {
    for_each = local.georeplication_locations
    content {
      location                = georeplications.value
      zone_redundancy_enabled = try(var.acr.zone_redundancy_enabled, false)
    }
  }

  dynamic "encryption" {
    for_each = (coalesce(var.acr.encryption_enabled, false) ? [1] : [])
    content {
      identity_client_id = try(var.acr.encryption_identity_client_id, null)
      key_vault_key_id = format(
        "%s/keys/%s/%s",
        var.acr.encryption_key_vault_id,
        var.acr.encryption_key_name,
        var.acr.encryption_key_version
      )
    }
  }

  dynamic "network_rule_set" {
    for_each = (
      length(local.network_rule_set.ip_rules) > 0 ||
      length(local.network_rule_set.virtual_network_subnet_ids) > 0
    ) ? [1] : []
    content {
      default_action = local.network_rule_set.default_action

      dynamic "ip_rule" {
        for_each = local.network_rule_set.ip_rules
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }
}
