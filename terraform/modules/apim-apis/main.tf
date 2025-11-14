##############################################################################
# Azure API Management APIs Module
#
# This module creates and configures APIs within an Azure API Management
# service. APIs represent backend services exposed through APIM.
#
# Features:
# - Multiple APIs via for_each
# - OpenAPI/Swagger import support
# - Versioning and revision support
# - Protocol configuration (HTTP/HTTPS/WebSocket)
# - Subscription requirements
##############################################################################

locals {
  apis = { for a in var.apim_apis.apis : a.name => a } # Create map for for_each
}

resource "azurerm_api_management_api" "api" {
  for_each = local.apis

  name                = each.key
  resource_group_name = var.apim_apis.resource_group_name
  api_management_name = var.apim_apis.api_management_name

  display_name          = coalesce(try(each.value.display_name, null), each.key)
  path                  = each.value.path                                      # URL path prefix
  protocols             = try(each.value.protocols, ["https"])                # http, https, ws, wss
  subscription_required = try(each.value.subscription_required, true)         # Require subscription key
  revision              = try(each.value.revision, "1")                       # API revision number
  version               = try(each.value.version, null)                       # API version
  version_set_id        = try(each.value.version_set_id, null)                # Version set resource ID
  service_url           = try(each.value.service_url, null)                   # Backend service URL
  description           = try(each.value.description, "")
  api_type              = try(each.value.api_type, "http")                    # http, soap, graphql, websocket

  # Import API definition from OpenAPI/Swagger spec
  dynamic "import" {
    for_each = (try(each.value.import_format, null) != null) && ((try(each.value.import_content, null) != null) || (try(each.value.import_path, null) != null)) ? [1] : []
    content {
      content_format = each.value.import_format # openapi, openapi+json, swagger-link-json, etc.
      content_value  = try(each.value.import_content, (try(each.value.import_path, null) != null ? file(each.value.import_path) : null))
    }
  }
}
