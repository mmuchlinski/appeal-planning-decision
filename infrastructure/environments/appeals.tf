/* API */
module "appeals-service-api" {
  source = "../modules/microservice"

  app_name = local.app_name
  location = var.location
  name = "appeals-service-api"
  name_format = local.name_format

  cosmos_enabled = false
  cosmos_mongodb_collections = [{
    name = "collection_name"
    shard_key = "_id"
    indices = [{
      keys = ["_id"]
      unique = true
    }]
  }]
  cosmos_auto_failover = true
  cosmos_failover_read_locations = var.mongodb_failover_read_locations
  cosmos_max_throughput = var.mongodb_max_throughput

  registry_config = data.azurerm_container_registry.pins

  web_app_envvars = {}
  web_app_image = "api-microservice"
  web_app_tag = "fix-docker-compose-setup"
  web_app_size = "S1"
  web_app_tier = "Standard"
  web_app_url_format = local.web_app_url_format
//  web_app_use_registry = false
}

/* Website */
