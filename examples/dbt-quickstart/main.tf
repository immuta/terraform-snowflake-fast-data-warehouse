terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = ">=0.23.2"
    }
  }
}

locals {
  public_role = "PUBLIC"
  sysadmin_role = "SYSADMIN"
}

// CORE RESOURCES
// This section generates base roles, warehouses and users
// It does NOT create grants between these users
module employees {
  source = "./modules/bulk_users"

  users = {
    "dev1"      = { login_name = "dev1@immuta.com" }
    "dev2"      = { login_name = "dev2@immuta.com" }
    "consumer1" = { name = "consumer", login_name = "consumer@immuta.com" }
  }
  default_role = module.bulk_roles.roles["reporter"]
}

module systems {
  source = "./modules/bulk_users"

  users = {
    "dbt"     = { name = "DBT" }
    "immuta"  = { name = "IMMUTA" }
    "meltano" = { name = "MELTANO" }
  }
}

module bulk_roles {
  source = "./modules/bulk_roles"

  roles = {
    loader      = { name = "LOADER" }
    transformer = { name = "TRANSFORMER" }
    reporter    = {}
  }
}

module bulk_warehouses {
  source = "./modules/bulk_warehouses"

  warehouses = {
    transform = { name = "TRANSFORM_WH" }
    report    = { name = "REPORTING_WH" }
  }
}

// APPLICATION DATABASES
// databases
module analytics_db {
  source = "./modules/application_database"

  db_name             = "ANALYTICS"
  grant_role_to_roles = ["SYSADMIN"]
  grant_role_to_users = [module.systems.users["dbt"].name]
  grant_read_to_roles = [module.bulk_roles.roles["reporter"].name]
}

module raw_db {
  source = "./modules/application_database"

  db_name             = "RAW"
  grant_role_to_roles = ["SYSADMIN"]
  grant_role_to_users = [module.systems.users["meltano"].name]
  grant_read_to_roles = [
    module.bulk_roles.roles["reporter"].name,
    module.bulk_roles.roles["transformer"].name,
  ]
}

module developer_dbs {
  for_each = ["dev1", "dev2"]
  source   = "./modules/application_database"

  db_name             = each.value
  create_user         = false
  create_warehouse    = false
  grant_role_to_users = [each.key]
}

// GRANTS
// Grants on core roles and warehouses need to be performed
// after all resources are defined and created.
resource snowflake_role_grants reporter {
  role_name = module.bulk_roles.roles["reporter"].name

  roles = [local.public_role, local.sysadmin_role]
  users = [module.systems.users["immuta"].name]
}

resource snowflake_warehouse_grant transform {
  warehouse_name = module.bulk_warehouses.warehouses["transform"].name

  roles = concat(
    [for m in module.developer_dbs : m.role.name],
    [module.analytics_db.role.name]
  )
}

resource snowflake_warehouse_grant report {
  warehouse_name = module.bulk_warehouses.warehouses["report"].name
  roles = [
    "PUBLIC",
    module.bulk_roles.roles["reporter"].name
  ]
}
