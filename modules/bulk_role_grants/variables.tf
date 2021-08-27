variable "grants" {
  default     = {}
  description = "Map of role grants to create. The module will look for default grant arguments, otherwise apply null."
  type = map(object({
    role_name = optional(string)
    users     = optional(list(string))
    roles     = optional(list(string))
    })
  )
}

variable "default_roles" {
  type        = list(string)
  description = "Roles to be granted access to the resource, if not specified."
  default     = []
}

variable "default_users" {
  type        = list(string)
  description = "Users to be granted access to the resource, if not specified."
  default     = []
}
