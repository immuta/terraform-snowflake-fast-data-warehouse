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
module "employees" {
  source = "./modules/core_users"
  users = {
    "tom"   = {}
    "jerry" = {
      first_name = "Ron"
      last_name = "Weasley"
    }
  }
}

module "core_roles" {
  source = "./modules/core_roles"
  roles = {
    "analyst" = { name = "ANALYST" }
  }
}

module "core_warehouses" {
  source = "./modules/core_warehouses"
  warehouses = {
    transform = { name = "TRANSFORM_WH" }
    report    = { name = "REPORTING_WH", size = "medium"}
  }
  default_size = "x-small"
  default_comment = "This is my warehouse comment."
}

// databases
module "example_db" {
  source = "./modules/application_database"

  db_name             = "ANALYTICS"
  grant_role_to_roles = []
  grant_role_to_users = [module.employees.users["tom"].name]
  grant_read_to_roles = [module.core_roles.roles["analyst"].name]
}

// role and warehouse grants
resource "snowflake_role_grants" "reporter" {
  role_name = module.core_roles.roles["analyst"].name

  roles = []
  users = [
    module.employees.users["jerry"].name
  ]
}

resource "snowflake_warehouse_grant" "transform" {
  warehouse_name = module.core_warehouses.warehouses["transform"].name

  roles = [module.core_roles.roles["analyst"].name]
}

resource "snowflake_warehouse_grant" "report" {
  warehouse_name = module.core_warehouses.warehouses["report"].name
  roles = [
    module.core_roles.roles["analyst"].name
  ]
}
