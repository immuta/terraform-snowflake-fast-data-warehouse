output "employee_users" {
  description = "Map of all employee users created."
  sensitive   = true
  value       = snowflake_user.employees
}

output "system_users" {
  description = "Map of all system users created."
  sensitive   = true
  value       = snowflake_user.systems
}

output "roles" {
  description = "Map of all roles created."
  value       = snowflake_role.core
}

output "warehouses" {
  description = "Map of all warehouses created."
  value       = snowflake_warehouse.core
}
