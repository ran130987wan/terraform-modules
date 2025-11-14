# vpn-gateway

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpn_gateway"></a> [vpn\_gateway](#input\_vpn\_gateway) | Configuration object for the VPN Gateway. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>    location            = string<br/><br/>    gateway_sku                   = optional(string, "VpnGw1")     # VpnGw1 | VpnGw2 | VpnGw3 | VpnGw4 | VpnGw5<br/>    gateway_type                  = optional(string, "Vpn")        # Vpn | ExpressRoute<br/>    vpn_type                      = optional(string, "RouteBased") # RouteBased | PolicyBased<br/>    private_ip_address_allocation = optional(string, "Dynamic")    # Dynamic | Static<br/>    gateway_subnet_id             = string<br/>    public_ip_id                  = string<br/>    vpn_client_address_pool       = list(string)<br/>    aad_tenant                    = string<br/>    aad_audience                  = string<br/>    aad_issuer                    = string<br/>    vpn_client_protocols          = optional(list(string), ["OpenVPN"]) # OpenVPN | IkeV2 | SSTP<br/>    tags                          = optional(map(string), {})<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | VPN Gateway resource ID. |
| <a name="output_name"></a> [name](#output\_name) | VPN Gateway name. |
<!-- END_TF_DOCS -->
