terraform {
  required_version = ">=0.14"
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.23.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.7.0"
    }
  }
}

// application database

resource "snowflake_database" "app" {
  name    = local.database_name
  comment = var.description
}

// application role

resource "snowflake_role" "app" {
  name    = snowflake_database.app.name
  comment = var.description
}

resource "snowflake_role_grants" "app" {
  role_name = snowflake_role.app.name

  roles = var.grant_role_to_roles
  users = local.grant_role_to_users
}
