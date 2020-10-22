output "location" {
  value = azurerm_resource_group.microservice.location
}
output "resource_group_name" {
  value = azurerm_resource_group.microservice.name
}

output "mongodb_primary_connection_string" {
  sensitive = true
  value = try(azurerm_cosmosdb_account.microservice[0].connection_strings[0], null)
}

output "mongodb_secondary_connection_string" {
  sensitive = true
  value = try(azurerm_cosmosdb_account.microservice[0].connection_strings[1], null)
}

output "mongodb_name" {
  value = try(azurerm_cosmosdb_mongo_database.mongodb[0].name, null)
}
