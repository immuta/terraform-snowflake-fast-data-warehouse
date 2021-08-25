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

resource snowflake_warehouse_grant main {
  for_each = var.grants

  warehouse_name    = coalesce(each.value["warehouse_name"], each.key)
  privilege = lookup(each.value, "privilege", var.default_privilege)
  roles = lookup(each.value, "roles", var.default_roles)
  with_grant_option = lookup(each.value, "with_grant_option", var.default_with_grant_option)
}
