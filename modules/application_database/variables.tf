variable "create_user" {
  default     = false
  description = "If true, will create a user with access to the database role."
  type        = bool
}

variable "create_warehouse" {
  default     = false
  description = "If true, will create a warehouse and grant it to the database role."
  type        = bool
}

variable "db_name" {
  description = "Application name will be used to create a user, role, database and warehouse."
  type        = string
}

variable "description" {
  default     = "Application resources managed by Terraform."
  description = "Application description used when creating resources"
  type        = string
}

variable "grant_role_to_roles" {
  default     = []
  description = "The roles that will have full access to app resources."
  type        = list(any)
}

variable "grant_role_to_users" {
  default     = []
  description = "The users that will have full access to app resources."
  type        = list(any)
}

variable "grant_read_to_roles" {
  default     = []
  description = "The roles that should have read access to database resources."
  type        = list(any)
}

variable "user_default_warehouse" {
  default     = null
  description = "The name of the warehouse to be used by the database_user, if applicable."
  type        = string
}

variable "warehouse_size" {
  default     = "x-small"
  description = "The size of the warehouse to be created, if applicable."
  type        = string
}

variable "warehouse_auto_suspend_time" {
  default     = 60
  description = "The suspension time of the warehouse to be created, if applicable."
  type        = number
}