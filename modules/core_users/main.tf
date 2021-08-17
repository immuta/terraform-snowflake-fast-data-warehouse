terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.18.1"
    }
    random = {
      version = ">=2.2.0"
    }
  }
}

resource "snowflake_user" "core" {
  for_each = var.users

  name                 = each.value["name"]
  comment              = lookup(each.value, "comment", local.default_comment)
  default_role         = lookup(each.value, "default_role", local.default_user_role)
  default_namespace    = lookup(each.value, "default_namespace", local.default_user_namespace)
  default_warehouse    = lookup(each.value, "default_warehouse", local.default_user_warehouse)
  display_name         = lookup(each.value, "display_name", var.default_display_name)
  email                = lookup(each.value, "email", var.default_email)
  first_name           = lookup(each.value, "first_name", var.default_first_name)
  last_name            = lookup(each.value, "last_name", var.default_last_name)
  login_name           = lookup(each.value, "login_name", var.default_login_name)
  must_change_password = lookup(each.value, "must_change_password", var.default_must_change_password)
  password             = lookup(each.value, "password", random_password.users[each.key].result)
}

resource "random_password" "users" {
  for_each = var.system_users

  length  = 16
  special = false
}
