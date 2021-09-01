// database user (optional)
resource "snowflake_user" "app" {
  count = var.create_application_user ? 1 : 0

  name                 = local.user_name
  login_name           = local.user_name
  password             = random_password.app_user[0].result
  default_role         = snowflake_role.admin.name
  default_namespace    = snowflake_database.app.name
  default_warehouse    = local.user_default_warehouse
  comment              = var.description
  must_change_password = false
}

resource "random_password" "app_user" {
  count = var.create_application_user ? 1 : 0

  length  = 16
  special = false
}