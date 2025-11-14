variable "apim_products" {
  description = "Configuration for API Management products to create."
  type = object({
    api_management_name = string
    resource_group_name = string
    products = list(object({
      display_name          = string
      description           = optional(string, "")
      product_id            = optional(string) # If omitted, Terraform will generate a name (use display_name slug)
      subscription_required = optional(bool, true)
      approval_required     = optional(bool, false)
      published             = optional(bool, true)
      terms                 = optional(string)
    }))
  })
}
