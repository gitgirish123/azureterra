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
  source   = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/resource_group?ref=main"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/vnet?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = var.address_space
}

module "dns" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/dns?ref=main"
  resource_group_name = module.resource_group.name
  zone_name           = var.dns_zone_name
}

module "cdn" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/cdn?ref=main"
  resource_group_name = module.resource_group.name
  origin_id           = module.blob_storage.id
}

module "api_management" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/api_management?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku_name            = var.apim_sku_name
}

module "load_balancer" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/load_balancer?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_id             = module.vnet.id
}

module "virtual_machine" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/virtual_machine?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_ids[0]
  vm_count            = var.vm_count
}

module "static_web_app" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/static_web_app?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = var.static_web_app_name
}

module "blob_storage" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/blob_storage?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "key_vault" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/key_vault?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "key_vault_certificates" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/key_vault_certificates?ref=main"
  key_vault_id        = module.key_vault.id
  certificates        = var.certificates
}

module "key_vault_keys" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/key_vault_keys?ref=main"
  key_vault_id        = module.key_vault.id
  keys                = var.keys
}

module "service_bus" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/service_bus?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "event_grid" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/event_grid?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "postgresql" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/postgresql?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  admin_username      = var.postgres_admin_username
  admin_password      = var.postgres_admin_password
}

module "redis_cache" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/redis_cache?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  capacity            = var.redis_capacity
}

module "monitor" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/monitor?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}
