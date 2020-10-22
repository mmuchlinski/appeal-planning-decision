/* Required variables */
variable "app_name" {}
variable "location" {}
variable "name" {}
variable "name_format" {}

variable "registry_config" {}
//variable "registry_password" {}
//variable "registry_url" {}
//variable "registry_username" {}

variable "web_app_url_format" {}
variable "web_app_size" {}
variable "web_app_tier" {}

variable "cosmos_enabled" {
  default = false
  type = bool
}
variable "cosmos_offer_type" {
  default = "Standard"
}
variable "cosmos_db_kind" {
  default = "MongoDB"
}
variable "cosmos_auto_failover" {
  default = true
  type = bool
}
variable "cosmos_capabilities" {
  default = [
    "EnableMongo",
    "mongoEnableDocLevelTTL"
  ]
  type = set(string)
}
variable "cosmos_failover_read_locations" {
  type = list(string)
  default = []
}
variable "cosmos_max_throughput" {
  type = number
  default = 4000
}
variable "cosmos_mongodb_collections" {
  type = list(object({
    name = string
    shard_key = string
    indices = set(object({
      keys = set(string)
      unique = bool
    }))
  }))
  default = []
}

/* Optional variables */
variable "env" {
  default = null
  type = string
}
variable "web_app_always_on" {
  default = true
  type = bool
}
variable "web_app_envvars" {
  default = {}
}
variable "web_app_healthcheck_url" {
  default = null
}

variable "web_app_image" {
  default = "nginx"
}
variable "web_app_is_reserved" {
  type = bool
  default = true
}
variable "web_app_kind" {
  default = "Linux"
}
variable "web_app_use_registry" {
  type = bool
  default = true
}
variable "web_app_tag" {
  default = "latest"
}
