variable "snowflake_account" {
  description = "The Snowflake account for resources to be loaded into."
  type        = string
}

variable "snowflake_region" {
  description = "The AWS region of the Snowflake account."
  type        = string
}

variable "snowflake_username" {
  description = "The username for the Snowflake Terraform user"
  type        = string
}

variable "snowflake_user_password" {
  description = "The password for the Snowflake Terraform user"
  type        = string
}

variable "snowflake_user_role" {
  default     = "TERRAFORM"
  description = "The role of the Terraform user."
  type        = string
}
