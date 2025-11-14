variable "dns_zone" {
  description = "Configuration object for the Private DNS Zone."
  type = object({
    name                = string
    resource_group_name = string
    tags                = optional(map(string), {})
    soa_record = optional(object({
      email        = string
      expire_time  = optional(number, 2419200)
      minimum_ttl  = optional(number, 10)
      refresh_time = optional(number, 3600)
      retry_time   = optional(number, 300)
      ttl          = optional(number, 3600)
    }), null)
  })
  default = {
    name                = ""
    resource_group_name = ""
    tags                = {}
  }
}
