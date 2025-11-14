variable "private_link_service" {
  description = "Configuration object for the Private Link Service."
  type = object({
    name                                        = string
    location                                    = string
    resource_group_name                         = string
    load_balancer_frontend_ip_configuration_ids = list(string)
    auto_approval_subscription_ids              = optional(list(string), [])
    visibility_subscription_ids                 = optional(list(string), [])
    fqdns                                       = optional(list(string), [])
    nat_ip_configuration = optional(object({
      name                       = string
      subnet_id                  = string
      private_ip_address         = optional(string)
      private_ip_address_version = optional(string, "IPv4")
      primary                    = optional(bool, true)
    }))
    tags = optional(map(string), {})
  })
  default = {
    name                                        = ""
    location                                    = ""
    resource_group_name                         = ""
    load_balancer_frontend_ip_configuration_ids = []
    auto_approval_subscription_ids              = []
    visibility_subscription_ids                 = []
    fqdns                                       = []
    nat_ip_configuration                        = null
    tags                                        = {}
  }
}
