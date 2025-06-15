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
  name                = var.vnet_name   # <-- Add this line
}


module "dns" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/dns?ref=main"
  resource_group_name = module.resource_group.name
  zone_name           = var.dns_zone_name
}

module "cdn" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/cdn?ref=main"
  resource_group_name = module.resource_group.name
  origin_host_header  = module.blob_storage.storage_account_primary_blob_endpoint
}


module "api_management" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/api_management?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku_name            = var.apim_sku_name
  publisher_name      = var.apim_publisher_name
  publisher_email     = var.apim_publisher_email
}

resource "azurerm_public_ip" "lb" {
  name                = "my-lb-public-ip"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


module "load_balancer" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/load_balancer?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  public_ip_id        = azurerm_public_ip.lb.id     # <-- ADD THIS LINE
  # vnet_id           = module.vnet.id             # <-- REMOVE THIS LINE
}


module "virtual_machine" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/virtual_machine?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  nic_id              = module.network_interface.nic_id  # <-- Add this (see step 2)
  vm_size             = var.vm_size                      # e.g., "Standard_B1s"
  admin_username      = var.vm_admin_username            # e.g., "azureuser"
  admin_password      = var.vm_admin_password            # <-- For Windows VMs
}


module "static_web_app" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/static_web_app?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = var.static_web_app_name
}

module "blob_storage" {
  source                   = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/blob_storage?ref=main"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  name                     = var.blob_storage_account_name
  account_tier             = var.blob_storage_account_tier
  account_replication_type = var.blob_storage_account_replication_type
}



data "azurerm_client_config" "current" {}

module "key_vault" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/key_vault?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = "my-keyvault-${random_pet.suffix.id}"   
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"                              
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
  namespace_name      = var.servicebus_namespace_name    
  sku                 = var.servicebus_sku               
}


module "event_grid" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/event_grid?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  topic_name          = var.event_grid_topic_name
}


module "postgresql" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/postgresql?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = var.postgresql_server_name         # Add this line
  sku_name            = var.postgresql_sku_name            # Add this line
  storage_mb          = var.postgresql_storage_mb           # Add this line
  postgres_version    = var.postgresql_version              # Add this line
  admin_username      = var.postgres_admin_username
  admin_password      = var.postgres_admin_password
}


module "redis_cache" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/redis_cache?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = "my-redis-${random_pet.suffix.id}"  # Globally unique name
  sku_name            = var.redis_sku_name                  # e.g., "Premium"
  family              = var.redis_family                    # e.g., "P" for Premium
  capacity            = var.redis_capacity                  # e.g., 1 (for Basic/Standard) or 2+ (for Premium)
}


module "monitor" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/monitor?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = "my-monitor-workspace"                
  sku                 = "PerGB2018"                           
  retention_in_days   = 30                                   
}

module "network_interface" {
  source              = "git::https://github.com/gitgirish123/azureterra.git//terraform_modules/network_interface?ref=main"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_ids[0]
  name                = "my-nic-${random_pet.suffix.id}" # <-- Add this line
  # Add any other required variables for your NIC module here
}
