variable "subnets" {
  description = "List of subnets to create inside the VNet. Supports optional service endpoints and delegations."
  type = list(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), [])
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), [])
    private_link_service_network_policies_disabled = optional(bool, false)
  }))
  default = []
}
