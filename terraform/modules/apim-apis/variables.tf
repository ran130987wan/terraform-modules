variable "apim_apis" {
  description = "Configuration for API Management APIs to create."
  type = object({
    api_management_name = string
    resource_group_name = string
    apis = list(object({
      name                  = string           # logical key (api_id)
      display_name          = optional(string) # defaults to name
      description           = optional(string, "")
      path                  = string                            # public path segment
      protocols             = optional(list(string), ["https"]) # http/https
      subscription_required = optional(bool, true)
      service_url           = optional(string) # backend URL
      revision              = optional(string, "1")
      version               = optional(string)
      version_set_id        = optional(string)
      api_type              = optional(string, "http") # http, graphql, websocket (azureRM provider supported subset)
      import_format         = optional(string)         # swagger, openapi, wsdl etc
      import_content        = optional(string)         # raw spec content (inline)
      import_path           = optional(string)         # file path to local spec (will use file() if set)
    }))
  })
}
