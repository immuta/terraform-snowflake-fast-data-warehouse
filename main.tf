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
module "example_core" {
  source = "./modules/core"

  employee_users = {"sbailey" = { name = "SBAILEY" } }
  system_users = {"immuta"  = { name = "IMMUTA" }}
  roles = {
    analyst    = { name = "REPORTER" }
  }
  warehouses = {
    transform = { name = "TRANSFORM_WH" }
    report    = { name = "REPORTING_WH" }
  }
}

// databases
module "example_db" {
  source = "./modules/app_database"

  db_name             = "ANALYTICS"
  grant_role_to_roles = ["SYSADMIN"]
  grant_role_to_users = [module.core.system_users["dbt"].name]
  grant_read_to_roles = [module.core.roles["reporter"].name]
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
