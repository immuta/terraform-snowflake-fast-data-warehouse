locals {
  create_warehouse_monitor = var.create_application_warehouse && var.create_application_warehouse_monitor
  database_name            = upper(var.database_name)
  grant_admin_to_users = (
    var.create_application_user ?
    concat(var.grant_admin_to_users, [snowflake_user.app[0].name]) :
    var.grant_admin_to_users
  )
  user_default_warehouse = (
    var.create_application_warehouse ?
    coalesce(var.application_user_default_warehouse, local.warehouse_name) :
    var.application_user_default_warehouse
  )
  create_reader_role_grants = length(var.grant_read_to_roles) > 0 || length(var.grant_read_to_users) > 0 ? 1 : 0
  user_name              = upper("${var.database_name}_USER")
  warehouse_name         = upper("${var.database_name}_WH")
  warehouse_monitor_name = upper("${local.warehouse_name}_MONITOR")
}