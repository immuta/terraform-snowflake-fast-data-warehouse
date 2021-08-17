variable "warehouses" {
  default     = {}
  description = "Map of warehouses to be created. Values from the 'snowflake_warehouse' resource will be applied. Key will be used as 'name' if not specified."
  type        = map
}

variable default_auto_resume {
  type = "boolean"
  default = true
}

variable default_auto_suspend {
  type = "string"
  default = 60
}

variable "default_comment" {
  type = "string"
  description = "Comment to be added to each warehouse, when no other comment specified."
  default = "Warehouse managed by Terraform."
}

variable default_size {
  type = "string"
  default = "x-small"
}
