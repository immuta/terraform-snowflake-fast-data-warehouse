output "warehouses" {
  description = "Map of all warehouses created."
  value       = snowflake_warehouse.main
}

output "resource_monitors" {
  description = "Map of all resource monitors created."
  value       = snowflake_resource_monitor.main
}
