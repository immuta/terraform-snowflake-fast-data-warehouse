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
  experiments = [module_variable_optional_attrs]
}

resource "snowflake_role" "main" {
  for_each = var.roles

  name    = coalesce(each.value["name"], each.key)
  comment = try(coalesce(each.value["comment"], var.default_comment), null)
}
