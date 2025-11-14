locals {
  apis = { for a in var.apim_apis.apis : a.name => a }
}

resource "azurerm_api_management_api" "api" {
  for_each = local.apis

  name                = each.key
  resource_group_name = var.apim_apis.resource_group_name
  api_management_name = var.apim_apis.api_management_name

  display_name          = coalesce(try(each.value.display_name, null), each.key)
  path                  = each.value.path
  protocols             = try(each.value.protocols, ["https"])
  subscription_required = try(each.value.subscription_required, true)
  revision              = try(each.value.revision, "1")
  version               = try(each.value.version, null)
  version_set_id        = try(each.value.version_set_id, null)
  service_url           = try(each.value.service_url, null)
  description           = try(each.value.description, "")
  api_type              = try(each.value.api_type, "http")

  dynamic "import" {
    for_each = (try(each.value.import_format, null) != null) && ((try(each.value.import_content, null) != null) || (try(each.value.import_path, null) != null)) ? [1] : []
    content {
      content_format = each.value.import_format
      content_value  = try(each.value.import_content, (try(each.value.import_path, null) != null ? file(each.value.import_path) : null))
    }
  }
}
