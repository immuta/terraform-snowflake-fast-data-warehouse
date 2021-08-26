variable grants {
  default     = {}
  description = "Map of warehouse grants to create. The module will look for default grant arguments, otherwise apply null."
  type        = map(any)
}

variable default_privilege {
  type        = string
  description = "Privilege to be granted if not specified. Additional privileges require an additional block."
  default     = "USAGE"
}

variable default_roles {
  type        = list
  description = "Roles to be granted access to the resource, if not specified."
  default     = []
}

variable default_with_grant_option {
  type        = bool
  description = "When this is set to true, allows the recipient role to grant the privileges to other roles.."
  default     = false
}
