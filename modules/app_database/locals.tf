locals {
  all_read_roles     = concat(var.grant_read_to_roles, [snowflake_role.app.name])
  all_elevated_roles = [snowflake_role.app.name]
  database_name      = upper(var.db_name)
  grant_role_to_users = (
    var.create_user ?
    concat(var.grant_role_to_users, [snowflake_user.app[0].name]) :
    var.grant_role_to_users
  )
  elevated_privileges = {
    database = [
      "CREATE SCHEMA",
      "MODIFY",
      "MONITOR",
    ]
    schema = [
      "CREATE EXTERNAL TABLE",
      "CREATE FILE FORMAT",
      "CREATE FUNCTION",
      "CREATE MASKING POLICY",
      "CREATE PIPE",
      "CREATE PROCEDURE",
      "CREATE STREAM",
      "CREATE TASK",
      "CREATE STAGE",
      "CREATE SEQUENCE",
      "CREATE TABLE",
      "CREATE VIEW",
      "MODIFY",
      "MONITOR",
    ]
    table = [
      "DELETE",
      "INSERT",
      "REFERENCES",
      "TRUNCATE",
      "UPDATE",
    ]
    view = []
  }
  read_privileges = {
    database = ["USAGE"]
    schema   = ["USAGE"]
    table    = ["SELECT"]
    view     = ["SELECT"]
  }
  user_default_warehouse = (
    var.create_warehouse ?
    coalesce(var.user_default_warehouse, local.warehouse_name) :
    var.user_default_warehouse
  )
  user_name      = upper("${var.db_name}_USER")
  warehouse_name = upper("${var.db_name}_WH")
}