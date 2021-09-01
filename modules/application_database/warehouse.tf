// database warehouse (optional)
resource "snowflake_warehouse" "app" {
  count = var.create_application_warehouse ? 1 : 0

  name           = local.warehouse_name
  auto_suspend   = var.application_warehouse_auto_suspend_time
  auto_resume    = var.application_warehouse_auto_resume_time
  comment        = var.description
  warehouse_size = var.application_warehouse_size
}

resource "snowflake_warehouse_grant" "app_role" {
  count = var.create_application_warehouse ? 1 : 0

  warehouse_name = local.warehouse_name
  privilege      = "USAGE"
  roles          = [snowflake_role.admin.name]
}

resource "time_offset" "monitor_start_times" {
  count = local.create_warehouse_monitor ? 1 : 0

  offset_days = 1
}

resource "snowflake_resource_monitor" "app" {
  count = local.create_warehouse_monitor ? 1 : 0

  name            = local.warehouse_monitor_name
  credit_quota    = 24
  frequency       = "DAILY"
  start_timestamp = formatdate("YYYY-MM-DD 00:00", time_offset.monitor_start_times[0].rfc3339)
  end_timestamp   = null

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
