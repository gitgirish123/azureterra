terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "suffix" {
  length = 1
}

module "resource_group" {
  source   = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/vnet"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = var.address_space
}

module "dns" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/dns"
  resource_group_name = module.resource_group.name
  zone_name           = var.dns_zone_name
}

module "cdn" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/cdn"
  resource_group_name = module.resource_group.name
  origin_id           = module.blob_storage.id
}

module "api_management" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/api_management"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku_name            = var.apim_sku_name
}

module "load_balancer" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/load_balancer"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_id             = module.vnet.id
}

module "virtual_machine" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/virtual_machine"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_ids[0]
  vm_count            = var.vm_count
}

module "static_web_app" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/static_web_app"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = var.static_web_app_name
}

module "blob_storage" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/blob_storage"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "key_vault" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/key_vault"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "key_vault_certificates" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/key_vault_certificates"
  key_vault_id        = module.key_vault.id
  certificates        = var.certificates
}

module "key_vault_keys" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/key_vault_keys"
  key_vault_id        = module.key_vault.id
  keys                = var.keys
}

module "service_bus" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/service_bus"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "event_grid" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/event_grid"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "postgresql" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/postgresql"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  admin_username      = var.postgres_admin_username
  admin_password      = var.postgres_admin_password
}

module "redis_cache" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/redis_cache"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  capacity            = var.redis_capacity
}

module "monitor" {
  source              = "https://github.com/gitgirish123/azureterra/tree/main/terraform_modules/monitor"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}
