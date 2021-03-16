variable "employee_users" {
  default     = {}
  description = "Map of employee users to be created. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type        = map
}

variable "roles" {
  default     = {}
  description = "Map of roles to create. 'name' required. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type        = map
}

variable "system_users" {
  default     = {}
  description = "Map of system users to be created. Values from the 'snowflake_user' resource will be applied. 'name' is required."
  type        = map
}

variable "warehouses" {
  default     = {}
  description = "Map of warehouses to be created. Values from the 'snowflake_warehouse' resource will be applied. 'name' is required."
  type        = map
}
