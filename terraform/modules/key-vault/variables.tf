variable "vault" {
  description = "Configuration object for the Azure Key Vault."
  type = object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku_name                        = optional(string, "standard") # standard | premium
    tenant_id                       = string
    soft_delete_retention_days      = optional(number, 7)
    purge_protection_enabled        = optional(bool, false)
    public_network_access_enabled   = optional(bool, true)
    enabled_for_disk_encryption     = optional(bool, false)
    enabled_for_deployment          = optional(bool, false)
    enabled_for_template_deployment = optional(bool, false)
    rbac_authorization_enabled      = optional(bool, true)
    access_policies = optional(list(object({
      tenant_id               = string
      object_id               = string
      key_permissions         = optional(list(string), [])
      secret_permissions      = optional(list(string), [])
      certificate_permissions = optional(list(string), [])
      storage_permissions     = optional(list(string), [])
    })), [])
    network_acls = optional(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }))
    tags = optional(map(string), {})
  })
  default = {
    name                            = ""
    location                        = ""
    resource_group_name             = ""
    sku_name                        = "standard"
    tenant_id                       = ""
    soft_delete_retention_days      = 7
    purge_protection_enabled        = true
    access_policies                 = []
    network_acls                    = null
    enabled_for_disk_encryption     = false
    enabled_for_deployment          = false
    enabled_for_template_deployment = false
    public_network_access_enabled   = false
    tags                            = {}
  }
}
