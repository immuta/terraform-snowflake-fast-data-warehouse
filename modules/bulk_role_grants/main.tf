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

resource snowflake_role_grants main {
  for_each = var.grants

  role_name    = coalesce(each.value["role_name"], each.key)
  roles = lookup(each.value, "roles", var.default_roles)
  users = lookup(each.value, "users", var.default_users)
}
