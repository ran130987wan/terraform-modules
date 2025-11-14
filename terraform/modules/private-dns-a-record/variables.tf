variable "private_dns_a_record" {
  description = "Configuration object for the Private DNS A record."
  type = object({
    name                = string
    zone_name           = string
    resource_group_name = string
    ttl                 = optional(number, 300)
    records             = list(string)
    enabled             = optional(bool, true)
    tags                = optional(map(string), {})
  })
  default = {
    name                = ""
    zone_name           = ""
    resource_group_name = ""
    ttl                 = 300
    records             = []
    enabled             = true
    tags                = {}
  }
}
