variable "vpn_gateway" {
  description = "Configuration object for the VPN Gateway."
  type = object({
    name                = string
    resource_group_name = string
    location            = string

    gateway_sku                   = optional(string, "VpnGw1")     # VpnGw1 | VpnGw2 | VpnGw3 | VpnGw4 | VpnGw5
    gateway_type                  = optional(string, "Vpn")        # Vpn | ExpressRoute
    vpn_type                      = optional(string, "RouteBased") # RouteBased | PolicyBased
    private_ip_address_allocation = optional(string, "Dynamic")    # Dynamic | Static
    gateway_subnet_id             = string
    public_ip_id                  = string
    vpn_client_address_pool       = list(string)
    aad_tenant                    = string
    aad_audience                  = string
    aad_issuer                    = string
    vpn_client_protocols          = optional(list(string), ["OpenVPN"]) # OpenVPN | IkeV2 | SSTP
    tags                          = optional(map(string), {})
  })
}
