variable "roles" {
  default     = {}
  description = "Map of roles to create. If 'name' is not specified, object key will be used."
  type        = map
}

variable "default_comment" {
  type = "string"
  description = "Comment to be added to each warehouse, when no other comment specified."
  default = "Warehouse managed by Terraform."
}