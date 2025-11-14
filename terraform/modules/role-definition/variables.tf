variable "role_definition" {
  description = "Configuration object for creating an Azure custom Role Definition (or referencing with provided GUID)."
  type = object({
    name               = string # Display name of role
    scope              = string # Management group or subscription scope
    description        = optional(string, "")
    role_definition_id = optional(string) # Predefined GUID if you want deterministic ID
    permissions = list(object({
      actions          = optional(list(string), [])
      not_actions      = optional(list(string), [])
      data_actions     = optional(list(string), [])
      not_data_actions = optional(list(string), [])
    }))
    assignable_scopes = optional(list(string)) # Defaults to [scope] if omitted
  })

  # Validation: Must provide at least one permissions block, and at least one action or data_action across all.
  validation {
    condition = length(var.role_definition.permissions) > 0 && (
      length(flatten([for p in var.role_definition.permissions : p.actions])) +
      length(flatten([for p in var.role_definition.permissions : p.data_actions])) > 0
    )
    error_message = "role_definition.permissions must include at least one block with actions or data_actions."
  }
}
