locals {
  all_admin_roles = [snowflake_role.admin.name]
  all_read_roles  = [snowflake_role.admin.name, snowflake_role.reader.name]
  // https://docs.snowflake.com/en/sql-reference/sql/grant-privilege.html
  admin_privileges = {
    database = ["CREATE SCHEMA"]
    schema = [
      "CREATE EXTERNAL TABLE",
      "CREATE FILE FORMAT",
      "CREATE FUNCTION",
      "CREATE MASKING POLICY",
      # "CREATE MATERIALIZED VIEW",   # Not GA yet
      "CREATE PIPE",
      "CREATE PROCEDURE",
      # "CREATE ROW ACCESS POLICY",   # Not GA yet
      "CREATE SEQUENCE",
      "CREATE STAGE",
      "CREATE STREAM",
      "CREATE TABLE",
      # "CREATE TAG",                 # Not GA yet
      "CREATE TASK",
      "CREATE VIEW",
      "MODIFY",
      "MONITOR",
    ]
    table = [
      "DELETE",
      "INSERT",
      "TRUNCATE",
      "UPDATE",
    ]
    view  = []
    // Public schema only
    external_table    = []
    file_format       = []
    function          = []
    # materialized_view = []
    masking_policy    = ["APPLY"]
    pipe              = ["OPERATE"]
    procedure         = []
    sequence          = []
    stage             = [] # Adding ["WRITE", "READ"] throws a 'Privilege Order' violation
    stream            = []
    task              = ["OPERATE"]
  }
  reader_privileges = {
    // Full application database
    database = ["USAGE"]
    schema   = ["USAGE"]
    table    = ["SELECT", "REFERENCES"]
    view     = ["SELECT", "REFERENCES"]
    // Public schema only
    external_table    = ["SELECT"]
    file_format       = ["USAGE"]
    function          = ["USAGE"]
    # materialized_view = ["SELECT"]
    masking_policy    = []
    pipe              = ["MONITOR"]
    procedure         = ["USAGE"]
    sequence          = ["USAGE"]
    stage             = ["USAGE"]
    stream            = ["SELECT"]
    task              = ["MONITOR"]
  }
  public_schema_name = "PUBLIC"
}


// read privileges on database + child objects
resource "snowflake_database_grant" "read" {
  for_each = toset(local.reader_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = concat(
    local.all_read_roles,
    var.grant_database_usage_to_roles
  )
}

resource "snowflake_schema_grant" "read" {
  for_each = toset(local.reader_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

resource "snowflake_schema_grant" "public_read" {
  for_each = toset(local.reader_privileges["schema"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = concat(
    local.all_read_roles,
    var.grant_database_usage_to_roles
  )
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

resource "snowflake_database_grant" "admin" {
  for_each = toset(local.admin_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_schema_grant" "admin" {
  for_each = toset(local.admin_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_schema_grant" "public_admin" {
  for_each = toset(local.admin_privileges["schema"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_table_grant" "admin" {
  for_each = toset(local.admin_privileges["table"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}

resource "snowflake_view_grant" "admin" {
  for_each = toset(local.admin_privileges["view"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_admin_roles
}

// schema level grants
// only applied to the PUBLIC schema
resource "snowflake_external_table_grant" "read" {
  for_each = toset(local.reader_privileges["external_table"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_file_format_grant" "read" {
  for_each = toset(local.reader_privileges["file_format"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_pipe_grant" "read" {
  for_each = toset(local.reader_privileges["pipe"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_procedure_grant" "read" {
  for_each = toset(local.reader_privileges["procedure"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_sequence_grant" "read" {
  for_each = toset(local.reader_privileges["sequence"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_stage_grant" "read" {
  for_each = toset(local.reader_privileges["stage"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}

resource "snowflake_stream_grant" "read" {
  for_each = toset(local.reader_privileges["stream"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_read_roles
  on_future     = true
}


// schema level admin grants
// only applied to the PUBLIC schema
resource "snowflake_external_table_grant" "admin" {
  for_each = toset(local.admin_privileges["external_table"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_file_format_grant" "admin" {
  for_each = toset(local.admin_privileges["file_format"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_pipe_grant" "admin" {
  for_each = toset(local.admin_privileges["pipe"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_procedure_grant" "admin" {
  for_each = toset(local.admin_privileges["procedure"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_sequence_grant" "admin" {
  for_each = toset(local.admin_privileges["sequence"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_stage_grant" "admin" {
  for_each = toset(local.admin_privileges["stage"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}

resource "snowflake_stream_grant" "admin" {
  for_each = toset(local.admin_privileges["stream"])

  database_name = snowflake_database.app.name
  schema_name   = local.public_schema_name
  privilege     = each.key
  roles         = local.all_admin_roles
  on_future     = true
}