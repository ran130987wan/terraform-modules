variable "public_ip" {
  description = "Configuration object for the Public IP resource."
  type = object({
    name                = string
    resource_group_name = string
    location            = string

    sku               = optional(string, "Standard") # Basic | Standard
    allocation_method = optional(string, "Static")   # Static | Dynamic
    ip_version        = optional(string, "IPv4")     # IPv4 | IPv6
    zones             = optional(list(string))       # e.g. ["1","2","3"]

    domain_name_label       = optional(string)
    reverse_fqdn            = optional(string)
    idle_timeout_in_minutes = optional(number) # 4-30
    public_ip_prefix_id     = optional(string)

    ddos_protection_mode    = optional(string) # Enabled | VirtualNetworkInherited
    ddos_protection_plan_id = optional(string)

    tags = optional(map(string), {})
  })
}
