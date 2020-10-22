resource "azurerm_cosmosdb_account" "microservice" {
  count = local.cosmos_count

  name = replace(format(var.name_format, var.name), "/\\W/", "")
  location = azurerm_resource_group.microservice.location
  resource_group_name = azurerm_resource_group.microservice.name
  offer_type = var.cosmos_offer_type
  kind = var.cosmos_db_kind

  enable_automatic_failover = var.cosmos_auto_failover

  dynamic "capabilities" {
    for_each = var.cosmos_capabilities
    content {
      name = capabilities.value
    }
  }

  consistency_policy {
    // @todo figure out which is best for requirements
    consistency_level = "Strong"
  }

  // @todo add write replicas

  geo_location {
    failover_priority = 0
    location = azurerm_resource_group.microservice.location
  }

  dynamic "geo_location" {
    for_each = var.cosmos_failover_read_locations
    content {
      failover_priority = geo_location.key + 1
      location = geo_location.value
    }
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  count = local.cosmos_mongodb_enabled ? 1 : 0

  name = replace(var.name, "/\\W/", "")
  resource_group_name = azurerm_resource_group.microservice.name
  account_name = azurerm_cosmosdb_account.microservice[count.index].name

  autoscale_settings {
    max_throughput = var.cosmos_max_throughput
  }
}

resource "azurerm_cosmosdb_mongo_collection" "mongodb" {
  count = local.cosmos_mongodb_enabled ? length(var.cosmos_mongodb_collections) : 0

  name = var.cosmos_mongodb_collections[count.index].name
  account_name = azurerm_cosmosdb_account.microservice[count.index].name
  database_name = azurerm_cosmosdb_mongo_database.mongodb[count.index].name
  resource_group_name = azurerm_resource_group.microservice.name

  shard_key = var.cosmos_mongodb_collections[count.index].shard_key

  dynamic "index" {
    for_each = var.cosmos_mongodb_collections[count.index].indices
    content {
      keys = index.value.keys
      unique = index.value.unique
    }
  }
}
