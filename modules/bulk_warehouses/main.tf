terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.23.1"
    }
    time = {
      version = ">=0.7.2"
    }
  }
  experiments = [module_variable_optional_attrs]
}

locals {
  monitored_warehouses = [
    for k, v in var.warehouses : k if coalesce(v.create_resource_monitor, var.default_create_resource_monitor)
  ]
}

resource "snowflake_warehouse" "main" {
  for_each = var.warehouses

  name           = lookup(each.value, "name", each.key)
  auto_suspend   = try(coalesce(each.value["auto_suspend"], var.default_auto_suspend), null)
  auto_resume    = try(coalesce(each.value["auto_resume"], var.default_auto_resume), null)
  comment        = try(coalesce(each.value["comment"], var.default_comment), null)
  warehouse_size = try(coalesce(each.value["warehouse_size"], var.default_size), null)
}

resource "time_offset" "monitor_start_times" {
  for_each = toset(local.monitored_warehouses)

  offset_days = 1
}

resource "snowflake_resource_monitor" "main" {
  for_each = toset(local.monitored_warehouses)

  name         = "${each.key}_monitor"
  credit_quota = 24

  frequency = "DAILY"
  start_timestamp = formatdate(
    "YYYY-MM-DD 00:00",
    time_offset.monitor_start_times[each.key].rfc3339
  )
  end_timestamp = null

  notify_triggers            = [100]
  suspend_triggers           = []
  suspend_immediate_triggers = []

  // Snowflake will convert the timestamp provided into a
  // localized format, causing continual errors if not ignored
  lifecycle {
    ignore_changes = [
      start_timestamp
    ]
  }
}