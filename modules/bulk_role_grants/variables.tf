variable grants {
  default     = {}
  description = "Map of role grants to create. The module will look for default grant arguments, otherwise apply null."
  type        = map(any)
}

variable default_roles {
  type        = list
  description = "Roles to be granted access to the resource, if not specified."
  default     = []
}

variable default_users {
  type        = list
  description = "Users to be granted access to the resource, if not specified."
  default     = []
}
