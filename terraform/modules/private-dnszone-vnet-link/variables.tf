variable "dns_zone_vnet_link" {
  description = "Configuration object for the Private DNS Zone Virtual Network Link."
  type = object({
    name                  = string
    resource_group_name   = string
    private_dns_zone_name = string
    virtual_network_id    = string
    registration_enabled  = optional(bool, false)
    resolution_policy     = optional(string) # Possible values: "Default" and "NxDomainRedirect"
    tags                  = optional(map(string), {})
  })
  default = {
    name                  = ""
    resource_group_name   = ""
    private_dns_zone_name = ""
    virtual_network_id    = ""
    registration_enabled  = false
    resolution_policy     = "Default"
  }
}
