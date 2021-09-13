variable "create_application_user" {
  default     = false
  description = "If true, creates a user with access to the database role."
  type        = bool
}

variable "create_application_warehouse" {
  default     = false
  description = "If true, creates a warehouse and grants it to the database role."
  type        = bool
}

variable "create_application_warehouse_monitor" {
  default     = false
  description = "If true, creates a warehouse monitor for the application warehouse. Requires ACCOUNTADMIN privileges."
  type        = bool
}

variable "admin_role_name_suffix" {
  default     = "_ADMIN"
  description = "The suffix appended to the database name to determine the admin role (e.g. APP_ADMIN)."
  type        = string
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
  description = "The database name will be used to drive the names of all application resources."
  type        = string
}

variable "description" {
  default     = "Application resources managed by Terraform."
  description = "Description to be applied to database resources."
  type        = string
}

variable "grant_admin_to_roles" {
  default     = []
  description = "Additional roles that will have full access to the module resources."
  type        = list(string)
}

variable "grant_admin_to_users" {
  default     = []
  description = "Additional users that will have full access to the module resources."
  type        = list(string)
}

variable "grant_read_to_roles" {
  default     = []
  description = "Additional roles that should have read access to module resources."
  type        = list(string)
}

variable "grant_read_to_users" {
  default     = []
  description = "Additional users that should have read access to module resources."
  type        = list(string)
}

variable "reader_role_name_suffix" {
  default     = "_READER"
  description = "The suffix appended to the database name to determine the reader role (e.g. APP_READER)."
  type        = string
}