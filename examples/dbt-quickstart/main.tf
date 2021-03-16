terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.23.2"
    }
  }
}

// This module generates base roles, warehouses and users
// It does NOT create grants between these users

module "core" {
  source = "./modules/core"

  employee_users = {
    "dev1"      = { name = "dev1", login_name = "dev1@immuta.com" }
    "dev2"      = { name = "dev2", login_name = "dev2@immuta.com" }
    "consumer1" = { name = "consumer", login_name = "consumer@immuta.com" }
  }
  system_users = {
    "dbt"     = { name = "DBT" }
    "immuta"  = { name = "IMMUTA" }
    "meltano" = { name = "MELTANO" }
  }
  roles = {
    loader      = { name = "LOADER" }
    transformer = { name = "TRANSFORMER" }
    reporter    = { name = "REPORTER" }

  }
  warehouses = {
    transform = { name = "TRANSFORM_WH" }
    report    = { name = "REPORTING_WH" }
  }
}

// databases
module "analytics_db" {
  source = "./modules/app_database"

  db_name             = "ANALYTICS"
  grant_role_to_roles = ["SYSADMIN"]
  grant_role_to_users = [module.core.system_users["dbt"].name]
  grant_read_to_roles = [module.core.roles["reporter"].name]
}

module "raw_db" {
  source = "./modules/app_database"

  db_name             = "RAW"
  grant_role_to_roles = ["SYSADMIN"]
  grant_role_to_users = [module.core.system_users["meltano"].name]
  grant_read_to_roles = [
    module.core.roles["reporter"].name,
    module.core.roles["transformer"].name,
  ]
}

module "developer_dbs" {
  for_each = ["dev1", "dev2"]
  source   = "./modules/app_database"

  db_name             = each.value
  create_user         = false
  create_warehouse    = false
  grant_role_to_users = [each.key]
}

// role and warehouse grants

resource "snowflake_role_grants" "reporter" {
  role_name = module.core.roles["reporter"].name

  roles = ["SYSADMIN"]
  users = ["PUBLIC", module.core.system_users["immuta"].name]
}

resource "snowflake_warehouse_grant" "transform" {
  warehouse_name = module.core.warehouses["transform"].name

  roles = concat(
    [for m in module.developer_dbs : m.role.name],
    [module.analytics_db.role.name]
  )
}

resource "snowflake_warehouse_grant" "report" {
  warehouse_name = module.core.warehouses["report"].name
  roles = [
    "PUBLIC",
    module.core.roles["reporter"].name
  ]
}
