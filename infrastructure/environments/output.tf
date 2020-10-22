/*
  Misc
 */

output "app-name" {
  description = "The application name - used for identifying resource groups"
  value = local.app_name
}

/*
  Appeals API
 */

output "appeals_api_mongodb_primary_connection_string" {
  description = "Primary connection string for the MongoDB"
  sensitive = true
  value = try(module.appeals-service-api.mongodb_primary_connection_string, null)
}

output "appeals_api_mongodb_secondary_connection_string" {
  description = "Secondary connection string for the MongoDB - to be used when generating new keys"
  sensitive = true
  value = try(module.appeals-service-api.mongodb_secondary_connection_string, null)
}

output "appeals_api_mongodb_name" {
  description = "MongoDB name"
  value = module.appeals-service-api.mongodb_name
}
