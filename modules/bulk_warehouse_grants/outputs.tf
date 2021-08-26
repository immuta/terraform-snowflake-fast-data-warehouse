output "grants" {
  description = "Map of all grants created."
  value       = snowflake_warehouse_grant.main
}
