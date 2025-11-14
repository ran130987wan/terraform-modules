
variable "natgw_public_ip_assoc" {
  description = "Configuration object for NAT Gateway public IP associations."
  type = object({
    nat_gateway_id = string
    public_ip_id   = string
  })
}
