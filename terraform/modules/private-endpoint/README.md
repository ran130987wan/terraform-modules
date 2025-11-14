# private-endpoint

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
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | Configuration object for the Private Endpoint. | <pre>object({<br/>    name                = string<br/>    location            = string<br/>    resource_group_name = string<br/>    subnet_id           = string<br/>    private_service_connection = object({<br/>      name                           = string<br/>      private_connection_resource_id = string<br/>      is_manual_connection           = optional(bool, false)<br/>      subresource_names              = optional(list(string), [])<br/>      request_message                = optional(string)<br/>    })<br/>    private_dns_zone_group = optional(object({<br/>      name                 = string<br/>      private_dns_zone_ids = list(string)<br/>    }))<br/>    tags = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "location": "",<br/>  "name": "",<br/>  "private_service_connection": {<br/>    "is_manual_connection": false,<br/>    "name": "",<br/>    "private_connection_resource_id": "",<br/>    "subresource_names": []<br/>  },<br/>  "resource_group_name": "",<br/>  "subnet_id": "",<br/>  "tags": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Endpoint. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private Endpoint. |
| <a name="output_private_endpoint_serviceconnection_details"></a> [private\_endpoint\_serviceconnection\_details](#output\_private\_endpoint\_serviceconnection\_details) | The private service connection details of the Private Endpoint. |
<!-- END_TF_DOCS -->
