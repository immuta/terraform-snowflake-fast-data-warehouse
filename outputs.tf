output "users" {
  description = "System users generated by the core module."
  sensitive   = true
  value       = module.employees.users
}

output "roles" {
  description = "System users generated by the core module."
  value       = module.bulk_roles.roles
}

output "warehouses" {
  description = "System users generated by the core module."
  value       = module.bulk_warehouses.warehouses
}

output "analytics_application" {
  description = "Manually selected applilcation users generated by each app_database module."
  sensitive   = true
  value       = module.example_db
}
