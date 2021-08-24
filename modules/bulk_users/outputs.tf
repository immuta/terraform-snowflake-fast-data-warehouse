output users {
  description = "Map of all system users created."
  sensitive   = true
  value       = snowflake_user.main
}
