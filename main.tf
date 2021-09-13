provider "snowflake" {
  account  = var.snowflake_account
  region   = var.snowflake_region
  username = var.snowflake_username
  password = var.snowflake_user_password
  role     = var.snowflake_user_role
}

locals {
  developer_list = ["harry", "hermione"]
}

module "employees" {
  source = "./modules/bulk_users"
  users = {
    "harry" = {}
    "ron" = {
      first_name = "Ronald"
    }
    "hermione" = {}
    "fred" = {
      login_name = "fred"
    }
  }

  default_role                   = "PUBLIC"
  default_generate_user_password = true
}

module "bulk_roles" {
  source = "./modules/bulk_roles"
  roles = {
    analyst = { name = "ANALYST_ROLE" }
  }
}

module "bulk_warehouses" {
  source = "./modules/bulk_warehouses"
  warehouses = {
    transform = {
      name                    = "TRANSFORM_WH"
      create_resource_monitor = true
    }
    report = {
      name = "REPORTING_WH"
      size = "medium"
    }
  }
  default_size    = "x-small"
  default_comment = "This is my warehouse comment."
}

// role and warehouse grants
module "bulk_role_grants" {
  source = "./modules/bulk_role_grants"
  grants = {
    analyst = {
      role_name = module.bulk_roles.roles["analyst"].name
      users     = [module.employees.users["harry"].name]
    }
  }
}

module "bulk_warehouse_grants" {
  source = "./modules/bulk_warehouse_grants"
  grants = {
    transform = {
      warehouse_name = module.bulk_warehouses.warehouses["transform"].name
      roles          = [module.bulk_roles.roles["analyst"].name]
    }
    report = {
      warehouse_name = module.bulk_warehouses.warehouses["report"].name
      roles          = [module.bulk_roles.roles["analyst"].name]
    }
  }
}

// databases
module "example_db" {
  source = "./modules/application_database"

  database_name        = "ANALYTICS"
  grant_admin_to_roles = []
  grant_admin_to_users = [module.employees.users["ron"].name]
  grant_read_to_roles  = [module.bulk_roles.roles["analyst"].name]
}

module "developer_dbs" {
  for_each = toset(local.developer_list)
  source   = "./modules/application_database"

  database_name                = module.employees.users[each.key].name
  create_application_user      = false
  create_application_warehouse = false
  grant_admin_to_users         = [module.employees.users[each.key].name]
}
