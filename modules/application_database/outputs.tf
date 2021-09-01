output "database" {
  description = "Database resource created for the app."
  value       = snowflake_database.app
}

output "admin_role" {
  description = "Admin resource created for the app. Should not be granted to roles and users outside of the module."
  value       = snowflake_role.admin
}

output "reader_role" {
  description = "Role resource created for the app. Should not be granted to roles and resources outside of the module."
  value       = snowflake_role.reader
}

output "user" {
  description = "User resource created for the app. May be null."
  value       = var.create_application_user ? snowflake_user.app[0] : null
}

output "warehouse" {
  description = "Warehouse resource created for the app. May be null."
  value       = var.create_application_warehouse ? snowflake_warehouse.app[0] : null
}