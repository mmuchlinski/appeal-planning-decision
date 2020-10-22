resource "azurerm_app_service_plan" "microservice" {
  name = format(var.name_format, local.name_alnum)
  resource_group_name = azurerm_resource_group.microservice.name
  location = azurerm_resource_group.microservice.location
  kind = var.web_app_kind
  reserved = var.web_app_is_reserved

  sku {
    size = var.web_app_size
    tier = var.web_app_tier
  }
}

resource "azurerm_app_service" "microservice" {
  app_service_plan_id = azurerm_app_service_plan.microservice.id
  resource_group_name = azurerm_resource_group.microservice.name
  location = azurerm_resource_group.microservice.location

  # Diverges from convention as this becomes the URL
  name = format(var.web_app_url_format, local.name_alnum)

  app_settings = merge({
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_REGISTRY_SERVER_URL = var.registry_config.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = var.registry_config.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.registry_config.admin_password
    DOCKER_ENABLE_CI = true
  }, var.web_app_envvars)

  // @todo
  logs {}

  site_config {
    always_on = var.web_app_always_on
    ftps_state = "Disabled"
    health_check_path = var.web_app_healthcheck_url
    linux_fx_version = "DOCKER|${local.img_and_name}"
  }
}

//// Promote stuff https://www.rubberduckdev.com/azure-github-webapp-deployment/

//resource "azurerm_app_service_slot" "cosmos-test" {
//  app_service_name = azurerm_app_service.ux.name
//  app_service_plan_id = azurerm_app_service_plan.web-apps.id
//  resource_group_name = azurerm_resource_group.web-apps.name
//  location = azurerm_resource_group.web-apps.location
//
//  name = "test"
//
//  app_settings = {
//    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
//    DOCKER_REGISTRY_SERVER_URL = var.registry_server
//    DOCKER_REGISTRY_SERVER_USERNAME = var.registry_username
//    DOCKER_REGISTRY_SERVER_PASSWORD = var.registry_password
//    DOCKER_ENABLE_CI = true
//    DB_NAME = azurerm_cosmosdb_mongo_database.mongodb.name
//    DB_URL = azurerm_cosmosdb_account.mongodb.connection_strings[0]
//    PORT = 3000
//  }
//}

//resource "azurerm_container_registry_webhook" "web-apps" {
//  actions = [
//    "push"
//  ]
//  location = var.registry_config.location
//  name = replace(format(var.name_format, local.name_alnum), "/\\W/", "")
//  registry_name = var.registry_config.name
//  resource_group_name = var.registry_config.resource_group_name
//  service_uri = "https://${azurerm_app_service.microservice.site_credential.0.username}:${azurerm_app_service.microservice.site_credential.0.password}@${azurerm_app_service.microservice.name}.scm.azurewebsites.net/docker/hook"
//  scope = local.img_and_name
//  status = "enabled"
//}
