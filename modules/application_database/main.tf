terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.23.2"
    }
  }
}

// application database

resource snowflake_database app {
  name    = local.database_name
  comment = var.description
}

// application role

resource snowflake_role app {
  name    = local.database_name
  comment = var.description
}

resource snowflake_role_grants app {
  role_name = snowflake_role.app.name

  roles = var.grant_role_to_roles
  users = local.grant_role_to_users
}

// read privileges on database + child objects

resource snowflake_database_grant read {
  for_each = toset(local.read_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = local.all_read_roles
}

resource snowflake_schema_grant read {
  for_each = toset(local.read_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

resource snowflake_table_grant read {
  for_each = toset(local.read_privileges["table"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

resource snowflake_view_grant read {
  for_each = toset(local.read_privileges["view"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_read_roles
}

// elevated privileges on database + child objects

resource snowflake_database_grant app_role {
  for_each = toset(local.elevated_privileges["database"])

  database_name = snowflake_database.app.name
  privilege     = each.key
  roles         = local.all_elevated_roles
}

resource snowflake_schema_grant app_role {
  for_each = toset(local.elevated_privileges["schema"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_elevated_roles
}

resource snowflake_table_grant app_role {
  for_each = toset(local.elevated_privileges["table"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_elevated_roles
}

resource snowflake_view_grant app_role {
  for_each = toset(local.elevated_privileges["view"])

  database_name = snowflake_database.app.name
  on_future     = true
  privilege     = each.key
  roles         = local.all_elevated_roles
}


