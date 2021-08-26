locals {
  all_read_roles     = concat(var.grant_read_to_roles, [snowflake_role.app.name])
  all_elevated_roles = [snowflake_role.app.name]
  database_name      = upper(var.database_name)
  grant_role_to_users = (
    var.create_application_user ?
    concat(var.grant_role_to_users, [snowflake_user.app[0].name]) :
    var.grant_role_to_users
  )
  elevated_privileges = {
    database = ["CREATE SCHEMA"]
    schema = [
      "CREATE EXTERNAL TABLE",
      "CREATE FILE FORMAT",
      "CREATE TABLE",
      "CREATE VIEW",
      "MODIFY"
    ]
    table = ["INSERT", "TRUNCATE", "UPDATE", "DELETE"]
    view  = []
  }
  read_privileges = {
    database = ["USAGE"]
    schema   = ["USAGE"]
    table    = ["SELECT"]
    view     = ["SELECT"]
  }
  user_default_warehouse = (
    var.create_application_warehouse ?
    coalesce(var.application_user_default_warehouse, local.warehouse_name) :
    var.application_user_default_warehouse
  )
  user_name      = upper("${var.database_name}_USER")
  warehouse_name = upper("${var.database_name}_WH")
  warehouse_monitor_name = upper("${local.warehouse_name}_MONITOR")
}