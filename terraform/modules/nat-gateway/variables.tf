variable "nat_gateway" {
  description = "Configuration object for Azure NAT Gateway"
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    tags                = map(string)
  })

  default = {
    name                = ""
    resource_group_name = ""
    location            = ""
    sku                 = "Standard"
    tags                = {}
  }
}
