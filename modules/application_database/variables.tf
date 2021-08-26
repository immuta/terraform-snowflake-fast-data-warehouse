variable "create_application_user" {
  default     = false
  description = "If true, will create a user with access to the database role."
  type        = bool
}

variable "create_application_warehouse" {
  default     = false
  description = "If true, will create a warehouse and grant it to the database role."
  type        = bool
}

variable "create_application_warehouse_monitor" {
  default     = false
  description = "If true, will create a warehouse monitor for the application warehouse. Requires ACCOUNTADMIN privileges."
  type        = bool
}

variable "application_user_default_warehouse" {
  default     = null
  description = "The name of the default warehouse to be used by the database_user. Only used when creating a user but not creating a warehouse."
  type        = string
}

variable "application_warehouse_size" {
  default     = "x-small"
  description = "The size of the warehouse to be created, if applicable."
  type        = string
}

variable "application_warehouse_auto_suspend_time" {
  default     = 60
  description = "The suspension time of the warehouse to be created, if applicable."
  type        = number
}

variable "application_warehouse_auto_resume_time" {
  default     = true
  description = "The suspension time of the warehouse to be created, if applicable."
  type        = bool
}

variable "database_name" {
  description = "Application name will be used to create a user, role, database and warehouse."
  type        = string
}

variable "description" {
  default     = "Application resources managed by Terraform."
  description = "Description to be applied to database resources."
  type        = string
}

variable "grant_role_to_roles" {
  default     = []
  description = "The roles that will have full access to app resources."
  type        = list(string)
}

variable "grant_role_to_users" {
  default     = []
  description = "The users that will have full access to app resources."
  type        = list(string)
}

variable "grant_read_to_roles" {
  default     = []
  description = "The roles that should have read access to database resources."
  type        = list(string)
}
