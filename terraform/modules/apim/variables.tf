variable "apim" {
  description = "API Management configuration."
  type = object({
    name                      = string
    resource_group_name       = string
    location                  = string
    publisher_email           = string
    publisher_name            = string
    sku_name                  = optional(string, "Developer_1") # (Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, BasicV2, Standard, StandardV2, Premium and PremiumV2. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1).
    tags                      = optional(map(string), {})
    identity_type             = optional(string) # SystemAssigned, UserAssigned, SystemAssigned,UserAssigned
    identity_ids              = optional(list(string), [])
    virtual_network_type      = optional(string, null) # None / External / Internal
    virtual_network_subnet_id = optional(string, null)
    public_network_access     = optional(string, "Enabled") # Enabled / Disabled
    zones                     = optional(list(string), [])
    protocols                 = optional(list(string), ["http", "https"])
    enable_client_certificate = optional(bool, false)
    enable_managed_identity   = optional(bool, true)
    notification_sender_email = optional(string, null)
    gateway_disabled          = optional(bool, false)
    publisher_portal_disabled = optional(bool, false)
    min_api_version           = optional(string, "2019-12-01")
    additional_locations = optional(list(object({
      location             = string
      capacity             = number
      gateway_disabled     = optional(bool, false)
      public_ip_address_id = optional(string, null)
      zones                = optional(list(string), [])
      subnet_id            = optional(string)
    })), [])
  })
}
