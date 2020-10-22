resource "azurerm_resource_group" "microservice" {
  location = var.location
  name = format(var.name_format, local.name_alnum)

  tags = {
    app = var.app_name
    env = local.env
    lock = local.lock_delete
  }
}
