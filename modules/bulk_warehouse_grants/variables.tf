variable "grants" {
  default     = {}
  description = "Map of warehouse grants to create. The module will look for default grant arguments, otherwise apply null."
  type = map(object({
    warehouse_name    = optional(string)
    privilege         = optional(string)
    roles             = optional(list(string))
    with_grant_option = optional(bool)
    })
  )
}

variable "default_privilege" {
  type        = string
  description = "Privilege to be granted if not specified. Additional privileges require an additional block."
  default     = "USAGE"
}

variable "default_roles" {
  type        = list(string)
  description = "Roles to be granted access to the resource, if not specified."
  default     = []
}

variable "default_with_grant_option" {
  type        = bool
  description = "When this is set to true, allows the recipient role to grant the privileges to other roles.."
  default     = false
}
