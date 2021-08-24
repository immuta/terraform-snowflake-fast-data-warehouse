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

resource snowflake_role main {
  for_each = var.roles

  name    = coalesce(each.value["name"], each.key)
  comment = lookup(each.value, "comment", var.default_comment)
}
