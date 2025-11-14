variable "federated_identity_credential" {
  description = "Configuration object for the Federated Identity Credential module."
  type = object({
    name                       = string
    application_object_id      = string
    issuer                     = string
    resource_group_name        = string
    parent_id                  = string
    subject                    = string
    audiences                  = list(string)
    claims_matching_expression = string
  })
  default = {
    name                       = ""
    application_object_id      = ""
    issuer                     = ""
    resource_group_name        = ""
    parent_id                  = ""
    subject                    = ""
    audiences                  = []
    claims_matching_expression = null
  }
}
