locals {
  public_role   = "PUBLIC"
  sysadmin_role = "SYSADMIN"
  employees = {
    "EMPLOYEE_A" = {
      name = "employee.a@immuta.com"
      login_name = "employee.a@immuta.com"
    }
    "EMPLOYEE_B" = {
      email = "employee.b@immuta.com"
    }
  }
  system_users = {
    "LOOKER_USER"    = {}
    "SUPERSET_USER"  = {}
    "IMMUTA_USER"    = {}
    "HIGHTOUCH_USER" = {}
    "DBT_CLOUD_USER" = {
      default_role = module.bulk_roles.roles["DBT_CLOUD"].name
    }
  }
}