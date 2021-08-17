variable "users" {
  default     = {}
  description = "Map of system users to be created. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type        = map(any)
}

variable "default_user_namespace" {
  type        = string
  description = "foo"
  default     = "PUBLIC"
}

variable "default_user_role" {
  type        = string
  description = "foo"
  default     = "PUBLIC"
}

variable "default_user_warehouse" {
  type        = string
  description = "foo"
  default     = "REPORTING_WH"
}

variable "default_display_name" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_email" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_first_name" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_last_name" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_login_name" {
  type        = string
  description = "foo"
  default     = null
}

variable "default_must_change_password" {
  type        = "boolean"
  description = "foo"
  default     = false
}