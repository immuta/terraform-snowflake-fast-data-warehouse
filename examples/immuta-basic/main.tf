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

  employee_users = local.employees
  system_users   = { "immuta" = { name = "IMMUTA_USER" } }
  roles          = { immuta = { name = "IMMUTA" } }
  warehouses = {
    governance = { name = "GOVERN_WH" }
    reporting  = { name = "REPORTING_WH" }
  }
}

// databases
module "stitch_db" {
  source = "./modules/app_database"

  db_name             = "STITCH"
  create_user         = true
  create_warehouse    = true
  grant_read_to_roles = [module.core.roles["immuta"].name]
}

module "fivetran_db" {
  source = "./modules/app_database"

  db_name             = "FIVETRAN"
  create_user         = true
  create_warehouse    = true
  grant_role_to_users = [module.core.roles["immuta"].name]
}

// role and warehouse grants

resource "snowflake_role_grants" "immuta" {
  role_name = module.core.roles["immuta"].name

  roles = ["SYSADMIN"]
  users = [module.core.system_users["immuta"].name]
}

resource "snowflake_warehouse_grant" "governance" {
  warehouse_name = module.core.warehouses["governance"].name

  roles = [[module.core.roles["immuta"].name]]
}

resource "snowflake_warehouse_grant" "report" {
  warehouse_name = module.core.warehouses["report"].name

  roles          = ["PUBLIC"]
}
