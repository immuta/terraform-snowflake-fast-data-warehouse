terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.25.0"
    }
    random = {
      version = ">=2.2.0"
    }
  }
}

resource snowflake_user main {
  for_each = var.users

  name                 = lookup(each.value, "name", each.key)
  comment              = lookup(each.value, "comment", var.default_comment)
  default_role         = lookup(each.value, "default_role", var.default_role)
  default_namespace    = lookup(each.value, "default_namespace", var.default_namespace)
  default_warehouse    = lookup(each.value, "default_warehouse", var.default_warehouse)
  display_name         = lookup(each.value, "display_name", var.default_display_name)
  email                = lookup(each.value, "email", var.default_email)
  first_name           = lookup(each.value, "first_name", var.default_first_name)
  last_name            = lookup(each.value, "last_name", var.default_last_name)
  login_name           = lookup(each.value, "login_name", var.default_login_name)
  must_change_password = lookup(each.value, "must_change_password", var.default_must_change_password)
  password             = lookup(each.value, "password", random_password.users[each.key].result)

  lifecycle_ignore {
    must_change_password
  }
}

resource random_password users {
  for_each = var.users

  length  = 16
  special = false
}
