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

resource "snowflake_warehouse" "main" {
  for_each = var.warehouses

  name           = coalesce(each.key, each.value["name"])
  auto_suspend   = lookup(each.value, "auto_suspend", var.default_auto_suspend)
  auto_resume    = lookup(each.value, "auto_resume", var.default_auto_resume)
  comment        = lookup(each.value, "comment", var.default_comment)
  warehouse_size = lookup(each.value, "warehouse_size", var.default_size)
}
