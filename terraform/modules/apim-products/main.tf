resource "azurerm_api_management_product" "product" {
  for_each = { for p in var.apim_products.products : coalesce(p.product_id, lower(replace(p.display_name, " ", "-"))) => p }

  api_management_name = var.apim_products.api_management_name
  resource_group_name = var.apim_products.resource_group_name

  product_id            = each.key
  display_name          = each.value.display_name
  description           = try(each.value.description, "")
  subscription_required = try(each.value.subscription_required, true)
  approval_required     = try(each.value.approval_required, false)
  published             = try(each.value.published, true)
  terms                 = try(each.value.terms, null)
}
