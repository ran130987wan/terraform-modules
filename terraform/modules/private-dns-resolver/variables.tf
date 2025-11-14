variable "dns_resolver" {
  description = "Configuration object for the Azure Private DNS Resolver."
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    virtual_network_id  = string
    inbound_subnet_id   = string
    outbound_subnet_id  = string
    tags                = optional(map(string), {})
  })
  default = {
    name                = ""
    location            = ""
    resource_group_name = ""
    virtual_network_id  = ""
    inbound_subnet_id   = ""
    outbound_subnet_id  = ""
    tags                = {}
  }
}
