variable "private_endpoint" {
  description = "Configuration object for the Private Endpoint."
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string
    private_service_connection = object({
      name                           = string
      private_connection_resource_id = string
      is_manual_connection           = optional(bool, false)
      subresource_names              = optional(list(string), [])
      request_message                = optional(string)
    })
    private_dns_zone_group = optional(object({
      name                 = string
      private_dns_zone_ids = list(string)
    }))
    tags = optional(map(string), {})
  })
  default = {
    name                = ""
    location            = ""
    resource_group_name = ""
    subnet_id           = ""
    private_service_connection = {
      name                           = ""
      private_connection_resource_id = ""
      is_manual_connection           = false
      subresource_names              = []
    }
    tags = {}
  }
}
