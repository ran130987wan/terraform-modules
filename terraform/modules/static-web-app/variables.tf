variable "staticwebapp" {
  type = object({
    name                               = string
    resource_group_name                = string
    location                           = string
    tags                               = optional(map(string))
    configuration_file_changes_enabled = optional(bool, true)
    preview_environments_enabled       = optional(bool, true)
    public_network_access_enabled      = optional(bool, true)
    sku_tier                           = optional(string, "Free")
    sku_size                           = optional(string, "Free")

    app_settings       = optional(map(string))
    basic_auth_enabled = bool
    basic_auth = optional(object({
      environments = optional(string)
      password     = optional(string)
    }), {})

    identity = optional(object({
      type = string
    }))
  })
}
