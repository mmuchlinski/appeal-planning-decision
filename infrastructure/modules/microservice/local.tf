locals {
  cosmos_count = var.cosmos_enabled ? 1 : 0
  cosmos_mongodb_enabled = var.cosmos_enabled && var.cosmos_db_kind == "MongoDB"
  env = var.env != null ? var.env : terraform.workspace
  img_and_name = "${var.web_app_use_registry ? var.registry_config.login_server : "docker.io"}/${var.web_app_image}:${var.web_app_tag}"
  lock_delete = "CanNotDelete"
  lock_none = null # Doesn't add tag
  lock_readonly = "ReadOnly"
  name_alnum = replace(var.name, "/\\W/", "")
}
