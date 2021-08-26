output "grants" {
  description = "Map of all grants created."
  value       = snowflake_role_grants.main
}
