// database warehouse (optional)

resource snowflake_warehouse app {
  count = var.create_warehouse ? 1 : 0

  name           = local.warehouse_name
  auto_suspend   = var.warehouse_auto_suspend_time
  comment        = var.description
  warehouse_size = var.warehouse_size
}

resource snowflake_warehouse_grant app_role {
  count = var.create_warehouse ? 1 : 0

  warehouse_name = local.warehouse_name
  privilege      = "USAGE"
  roles          = [snowflake_role.app.name]
}