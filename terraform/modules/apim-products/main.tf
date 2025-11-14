##############################################################################
# Azure API Management Products Module
#
# This module creates products in APIM. Products are containers for APIs
# that define access policies, quotas, and terms of use for API consumers.
#
# Features:
# - Group multiple APIs together
# - Subscription management
# - Approval workflows
# - Usage quotas and rate limits
##############################################################################

resource "azurerm_api_management_product" "product" {
  for_each = { for p in var.apim_products.products : coalesce(p.product_id, lower(replace(p.display_name, " ", "-"))) => p }

  api_management_name = var.apim_products.api_management_name
  resource_group_name = var.apim_products.resource_group_name

  product_id            = each.key                                        # Product identifier
  display_name          = each.value.display_name                        # Display name in portal
  description           = try(each.value.description, "")
  subscription_required = try(each.value.subscription_required, true)    # Require subscription
  approval_required     = try(each.value.approval_required, false)       # Admin approval for subscriptions
  published             = try(each.value.published, true)                # Visible in developer portal
  terms                 = try(each.value.terms, null)                    # Terms of use text
}
