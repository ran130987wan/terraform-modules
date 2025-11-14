# apim-products

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
| [azurerm_api_management_product.product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_products"></a> [apim\_products](#input\_apim\_products) | Configuration for API Management products to create. | <pre>object({<br/>    api_management_name = string<br/>    resource_group_name = string<br/>    products = list(object({<br/>      display_name          = string<br/>      description           = optional(string, "")<br/>      product_id            = optional(string) # If omitted, Terraform will generate a name (use display_name slug)<br/>      subscription_required = optional(bool, true)<br/>      approval_required     = optional(bool, false)<br/>      published             = optional(bool, true)<br/>      terms                 = optional(string)<br/>    }))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_product_display_names"></a> [product\_display\_names](#output\_product\_display\_names) | n/a |
| <a name="output_product_ids"></a> [product\_ids](#output\_product\_ids) | Map of product logical keys to full resource IDs. |
<!-- END_TF_DOCS -->
