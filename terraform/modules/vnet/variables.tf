variable "vnet" {
  description = "Configuration object for the Virtual Network module."
  type = object({
    name                    = string
    resource_group_name     = string
    location                = string
    address_space           = list(string)
    tags                    = map(string)
    ddos_protection_plan_id = optional(string)
  })
  default = {
    name                    = ""
    resource_group_name     = ""
    location                = ""
    address_space           = []
    tags                    = {}
    ddos_protection_plan_id = null
  }
}
