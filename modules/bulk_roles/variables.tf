variable "roles" {
  default     = {}
  description = "Map of roles to create. 'name' required. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type = map(object({
    name    = optional(string)
    comment = optional(string)
    })
  )
}

variable "default_comment" {
  type        = string
  description = "Comment to be added to each warehouse, when no other comment specified."
  default     = "Role managed by Terraform."
}
