##############################################################################
# Azure Container Registry (ACR) Module - Variables
#
# Input configuration for creating and managing an Azure Container Registry.
# This variable defines all configurable options for the ACR instance including
# networking, security, replication, and encryption settings.
##############################################################################

variable "acr" {
  description = "Configuration object for Azure Container Registry"
  type = object({
    # Required basic configuration
    name                = string       # Globally unique ACR name (alphanumeric, 5-50 chars)
    resource_group_name = string       # Resource group where ACR will be created
    location            = string       # Azure region (e.g., eastus, westeurope)
    sku                 = string       # Pricing tier: Basic, Standard, or Premium
    admin_enabled       = bool         # Enable admin user for basic authentication
    tags                = map(string)  # Resource tags for organization and billing

    # Network and access configuration
    public_network_access_enabled = bool            # Allow access from public internet
    anonymous_pull_enabled        = optional(bool)  # Allow unauthenticated image pulls
    data_endpoint_enabled         = optional(bool)  # Enable dedicated data endpoints per region
    zone_redundancy_enabled       = optional(bool)  # Replicate across availability zones (Premium only)

    # Network access control rules
    network_rule_set = optional(object({
      default_action             = string       # "Allow" or "Deny" for unlisted traffic
      ip_rules                   = list(string) # Allowed IP addresses/CIDR ranges
      virtual_network_subnet_ids = list(string) # Allowed VNet subnet IDs
    }))

    # Geo-replication configuration (Premium SKU only)
    georeplication_locations = optional(list(string)) # List of Azure regions for replication

    # Managed identity configuration
    identity_type = optional(string)       # "SystemAssigned", "UserAssigned", or "SystemAssigned, UserAssigned"
    identity_ids  = optional(list(string)) # List of user-assigned identity resource IDs

    # Customer-managed encryption (Premium SKU only)
    encryption_enabled      = optional(bool)   # Enable encryption with customer-managed keys
    encryption_key_vault_id = optional(string) # Key Vault ID containing encryption key
    encryption_key_name     = optional(string) # Name of the encryption key
    encryption_key_version  = optional(string) # Specific version of the encryption key

    # Security and compliance policies
    export_policy_enabled     = optional(bool) # Allow artifact exports
    quarantine_policy_enabled = optional(bool) # Quarantine images until scanned

    # Output control flags
    admin_username_output = optional(bool) # Include admin username in outputs
    admin_password_output = optional(bool) # Include admin password in outputs (sensitive)
  })

  default = {
    name                = ""
    resource_group_name = ""
    location            = ""
    sku                 = "Standard"
    admin_enabled       = false
    tags                = {}

    public_network_access_enabled = true
    anonymous_pull_enabled        = false
    data_endpoint_enabled         = false
    zone_redundancy_enabled       = false

    network_rule_set = {
      default_action             = "Allow"
      ip_rules                   = []
      virtual_network_subnet_ids = []
    }

    georeplication_locations = []

    identity_type = "SystemAssigned"
    identity_ids  = []

    encryption_enabled      = false
    encryption_key_vault_id = ""
    encryption_key_name     = ""
    encryption_key_version  = ""

    export_policy_enabled     = false
    quarantine_policy_enabled = false

    admin_username_output = false
    admin_password_output = false
  }
}
