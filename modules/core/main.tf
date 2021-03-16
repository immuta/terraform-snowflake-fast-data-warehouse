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

resource "snowflake_user" "employees" {
  for_each = var.employee_users

  name                 = each.value["name"]
  comment              = lookup(each.value, "comment", local.default_comment)
  default_role         = lookup(each.value, "default_role", local.default_employee_user_role)
  default_namespace    = lookup(each.value, "default_namespace", local.default_employee_user_namespace)
  default_warehouse    = lookup(each.value, "default_warehouse", local.default_employee_user_warehouse)
  display_name         = lookup(each.value, "display_name", null)
  email                = lookup(each.value, "email", null)
  first_name           = lookup(each.value, "first_name", null)
  last_name            = lookup(each.value, "last_name", null)
  login_name           = lookup(each.value, "login_name", null)
  must_change_password = lookup(each.value, "must_change_password", false)
}

resource "snowflake_user" "systems" {
  for_each = var.system_users

  name                 = each.value["name"]
  comment              = lookup(each.value, "comment", local.default_comment)
  default_role         = lookup(each.value, "default_role", local.default_system_user_role)
  default_namespace    = lookup(each.value, "default_namespace", local.default_system_user_namespace)
  default_warehouse    = lookup(each.value, "default_warehouse", local.default_system_user_warehouse)
  display_name         = lookup(each.value, "display_name", null)
  email                = lookup(each.value, "email", null)
  first_name           = lookup(each.value, "first_name", null)
  last_name            = lookup(each.value, "last_name", null)
  login_name           = lookup(each.value, "login_name", null)
  must_change_password = lookup(each.value, "must_change_password", false)
  password             = random_password.system_users[each.key].result
}

resource "random_password" "system_users" {
  for_each = var.system_users

  length  = 16
  special = false
}

resource "snowflake_role" "core" {
  for_each = var.roles

  name    = each.value["name"]
  comment = lookup(each.value, "comment", local.default_comment)
}

resource "snowflake_warehouse" "core" {
  for_each = var.warehouses

  name           = each.value["name"]
  auto_resume    = lookup(each.value, "auto_resume", true)
  auto_suspend   = lookup(each.value, "auto_suspend", local.default_warehouse_auto_suspend)
  comment        = lookup(each.value, "comment", local.default_comment)
  warehouse_size = lookup(each.value, "warehouse_size", local.default_warehouse_size)
}
