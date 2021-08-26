variable "users" {
  default     = {}
  description = "Map of users to be created. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type = map(object({
    name                   = optional(string)
    comment                = optional(string)
    display_name           = optional(string)
    email                  = optional(string)
    first_name             = optional(string)
    must_change_password   = optional(bool)
    default_namespace      = optional(string)
    default_role           = optional(string)
    last_name              = optional(string)
    login_name             = optional(string)
    default_warehouse      = optional(string)
    generate_user_password = optional(bool)
    }
    )
  )
}

variable "default_comment" {
  type        = string
  description = "Comment to be added to each warehouse, when no other comment specified."
  default     = "User managed by Terraform."
}

variable "default_namespace" {
  type        = string
  description = "foo"
  default     = "PUBLIC"
}

variable "default_role" {
  type        = string
  description = "foo"
  default     = "PUBLIC"
}

variable "default_warehouse" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_must_change_password" {
  type        = bool
  description = "foo"
  default     = false
}

variable "default_generate_user_password" {
  type        = bool
  description = "If true, Terraform will generate a random password for the user."
  default     = false
}
