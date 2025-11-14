variable "acr" {
  description = "Configuration object for Azure Container Registry"
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool
    tags                = map(string)

    public_network_access_enabled = bool
    anonymous_pull_enabled        = optional(bool)
    data_endpoint_enabled         = optional(bool)
    zone_redundancy_enabled       = optional(bool)

    network_rule_set = optional(object({
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    }))

    georeplication_locations = optional(list(string))

    identity_type = optional(string)
    identity_ids  = optional(list(string))

    encryption_enabled      = optional(bool)
    encryption_key_vault_id = optional(string)
    encryption_key_name     = optional(string)
    encryption_key_version  = optional(string)

    export_policy_enabled     = optional(bool)
    quarantine_policy_enabled = optional(bool)

    admin_username_output = optional(bool)
    admin_password_output = optional(bool)
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
