locals {
  all_admin_roles = [snowflake_role.admin.name]
  all_read_roles  = [snowflake_role.admin.name, snowflake_role.reader.name]
  // https://docs.snowflake.com/en/sql-reference/sql/grant-privilege.html
  admin_privileges = {
    database = ["CREATE SCHEMA"]
    schema = [
      "MODIFY",
      "MONITOR",
      "CREATE TABLE",
      "CREATE EXTERNAL TABLE",
      "CREATE VIEW",
      "CREATE MATERIALIZED VIEW",
      "CREATE MASKING POLICY",
      # "CREATE ROW ACCESS POLICY",
      # "CREATE TAG",
      "CREATE SEQUENCE",
      "CREATE FUNCTION",
      "CREATE PROCEDURE",
      "CREATE FILE FORMAT",
      "CREATE STAGE",
      "CREATE PIPE",
      "CREATE STREAM",
      "CREATE TASK"
    ]
    table = ["INSERT", "TRUNCATE", "UPDATE", "DELETE"]
    view  = []
  }
  reader_privileges = {
    database = ["USAGE"]
    schema   = ["USAGE"]
    table    = ["SELECT", "REFERENCES"]
    view     = ["SELECT", "REFERENCES"]
  }
}


// read privileges on database + child objects
resource "snowflake_database_grant" "read" {
  for_each = toset(local.reader_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = local.all_read_roles
}

resource "snowflake_schema_grant" "read" {
  for_each = toset(local.reader_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

resource "snowflake_table_grant" "read" {
  for_each = toset(local.reader_privileges["table"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

resource "snowflake_view_grant" "read" {
  for_each = toset(local.reader_privileges["view"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

// elevated privileges on database + child objects

resource "snowflake_database_grant" "app_role" {
  for_each = toset(local.admin_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_schema_grant" "app_role" {
  for_each = toset(local.admin_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_table_grant" "app_role" {
  for_each = toset(local.admin_privileges["table"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_view_grant" "app_role" {
  for_each = toset(local.admin_privileges["view"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}
