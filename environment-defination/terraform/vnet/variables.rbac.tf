variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = optional(string, null)
    role_definition_id   = optional(string, null)
  }))
  default     = []
  description = "List of role assignments (principal_id and role_definition_name_or_id required)"

  validation {
    condition = alltrue([
      for ra in var.role_assignments :
      (ra.role_definition_id != null) != (ra.role_definition_name != null)
    ])
    error_message = "Exactly one of role_definition_id or role_definition_name must be set for each role assignment."
  }
}
