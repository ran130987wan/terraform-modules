variable "server_apis" {
  description = "API configuration that can be consumed from the authorized applications"
  type = object({
    name        = string
    identifier  = string
    signing_alg = optional(string, "RS256")
  })
  default = {
    name        = ""
    identifier  = ""
    signing_alg = "RS256"
  }
}

variable "client_application" {
  description = "set up applications that use Auth0 for authentication"
  type = object({
    name                        = string
    description                 = string
    app_type                    = string
    grant_types                 = optional(list(string))
    callbacks                   = optional(list(string))
    allowed_origins             = optional(list(string))
    allowed_logout_urls         = optional(list(string))
    web_origins                 = optional(list(string))
    require_proof_of_possession = optional(bool)
    refresh_token = optional(object({
      rotation_type   = string
      expiration_type = string
      leeway          = optional(number, 0)
      token_lifetime  = optional(number, 0)
    }))
  })
}

variable "client_grant" {
  description = "Auth0 uses various grant types, or methods by which you grant limited access to your resources to another entity without exposing credentials"
  type = object({
    scopes = optional(list(string), [])
  })
}

