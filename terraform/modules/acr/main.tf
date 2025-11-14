##############################################################################
# Azure Container Registry (ACR) Module
# 
# This module creates and configures an Azure Container Registry for storing
# and managing Docker container images and other artifacts.
#
# Features:
# - Supports Basic, Standard, and Premium SKUs
# - Optional geo-replication for high availability
# - Network access controls (IP rules, VNet integration)
# - Customer-managed encryption keys
# - Managed identity support
# - Admin user configuration
##############################################################################

# Local variables for setting defaults and normalizing configuration
locals {
  # Network rule set defaults - allows all traffic if not specified
  network_rule_set = (
    var.acr.network_rule_set != null
    ? var.acr.network_rule_set
    : {
      default_action             = "Allow"
      ip_rules                   = []
      virtual_network_subnet_ids = []
    }
  )

  # Geo-replication locations list - empty if not using geo-replication
  georeplication_locations = (
    var.acr.georeplication_locations != null
    ? var.acr.georeplication_locations
    : []
  )
}

# Main Azure Container Registry resource
resource "azurerm_container_registry" "acr" {
  # Basic configuration
  name                = var.acr.name
  resource_group_name = var.acr.resource_group_name
  location            = var.acr.location
  tags                = try(var.acr.tags, {})

  # SKU tier: Basic, Standard, or Premium
  sku = try(var.acr.sku, "Standard")

  # Access and security settings
  admin_enabled                 = try(var.acr.admin_enabled, false)         # Enable admin user for basic auth
  public_network_access_enabled = try(var.acr.public_network_access_enabled, true) # Allow public internet access
  anonymous_pull_enabled        = try(var.acr.anonymous_pull_enabled, false) # Allow anonymous pulls
  data_endpoint_enabled         = try(var.acr.data_endpoint_enabled, false)  # Enable dedicated data endpoints
  
  # High availability and compliance features
  zone_redundancy_enabled   = try(var.acr.zone_redundancy_enabled, false)   # Replicate across availability zones
  export_policy_enabled     = try(var.acr.export_policy_enabled, false)     # Allow artifact exports
  quarantine_policy_enabled = try(var.acr.quarantine_policy_enabled, false) # Quarantine unscanned images

  # Managed identity configuration for accessing other Azure resources
  dynamic "identity" {
    for_each = coalesce([var.acr.identity_type], []) != [] ? [var.acr.identity_type] : []
    content {
      type         = var.acr.identity_type        # SystemAssigned or UserAssigned
      identity_ids = try(var.acr.identity_ids, []) # List of user-assigned identity IDs
    }
  }

  # Geo-replication configuration for multi-region availability
  # Requires Premium SKU
  dynamic "georeplications" {
    for_each = local.georeplication_locations
    content {
      location                = georeplications.value # Azure region for replication
      zone_redundancy_enabled = try(var.acr.zone_redundancy_enabled, false)
    }
  }

  # Customer-managed encryption key configuration
  # Requires Premium SKU and user-assigned managed identity
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

  # Network access control rules
  # Only created if IP rules or VNet subnet IDs are specified
  dynamic "network_rule_set" {
    for_each = (
      length(local.network_rule_set.ip_rules) > 0 ||
      length(local.network_rule_set.virtual_network_subnet_ids) > 0
    ) ? [1] : []
    content {
      default_action = local.network_rule_set.default_action # Allow or Deny

      # IP-based access rules
      dynamic "ip_rule" {
        for_each = local.network_rule_set.ip_rules
        content {
          action   = "Allow"
          ip_range = ip_rule.value # CIDR notation (e.g., 203.0.113.0/24)
        }
      }
    }
  }
}
