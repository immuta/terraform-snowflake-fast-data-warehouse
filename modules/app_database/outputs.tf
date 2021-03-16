output "database" {
  description = "Database resource created for the app."
  value = snowflake_database.app
}

output "role" {
  description = "Role resource created for the app."
  value = snowflake_role.app
}

output "user" {
  desription = "User resource created for the app. May be null."
  value = var.create_user ? snowflake_user.app[0] : null
}

output "warehouse" {
  desription = "Warehouse resource created for the app. May be null."
  value = var.create_warehouse ? snowflake_warehouse.app[0] : null
}