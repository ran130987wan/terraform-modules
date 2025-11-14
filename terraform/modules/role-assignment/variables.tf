variable "role_assignment" {
  description = "Configuration object for the Role Assignment."
  type = object({
    scope                            = string
    principal_id                     = string
    principal_type                   = optional(string)
    role_definition_name             = optional(string)
    role_definition_id               = optional(string)
    condition                        = optional(string)
    condition_version                = optional(string)
    description                      = optional(string, "")
    skip_service_principal_aad_check = optional(bool, false)
  })

  # Validation: Exactly one of role_definition_name or role_definition_id must be provided. Using XOR logic here
  validation {
    condition     = ((var.role_assignment.role_definition_name != null) != (var.role_assignment.role_definition_id != null))
    error_message = "Exactly one of role_definition_name or role_definition_id must be set (and not both)."
  }
}
