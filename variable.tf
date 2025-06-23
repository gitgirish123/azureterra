variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "East US"
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_zone_name" {
  description = "DNS zone name for Azure DNS."
  type        = string
}

variable "apim_sku_name" {
  description = "SKU name for API Management."
  type        = string
  default     = "Consumption_0"
}

variable "vm_count" {
  description = "Number of virtual machines to deploy."
  type        = number
  default     = 1
}

variable "static_web_app_name" {
  description = "Name of the Azure Static Web App."
  type        = string
}

variable "certificates" {
  description = "List of certificates to be created in Key Vault."
  type = list(object({
    name     = string
    contents = string
    password = string
  }))
  default = []
}

variable "keys" {
  description = "List of keys to be created in Key Vault."
  type = list(object({
    name        = string
    key_type    = string
    key_size    = number
    key_opts    = list(string)
    curve_name  = string
  }))
  default = []
}

variable "postgres_admin_username" {
  description = "Admin username for PostgreSQL DB."
  type        = string
  default     = "pgadmin"
}

variable "postgres_admin_password" {
  description = "Admin password for PostgreSQL DB."
  type        = string
  sensitive   = true
}

variable "redis_capacity" {
  description = "Capacity for Azure Cache for Redis."
  type        = number
  default     = 2
}
variable "apim_publisher_name" {
  description = "The name of the API Management publisher."
  type        = string
}

variable "apim_publisher_email" {
  description = "The email of the API Management publisher."
  type        = string
}

variable "event_grid_topic_name" {
  description = "The name of the Event Grid Topic."
  type        = string
}

variable "servicebus_namespace_name" {
  description = "The name of the Service Bus Namespace."
  type        = string
}

variable "servicebus_sku" {
  description = "The SKU for the Service Bus Namespace (e.g., Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "redis_sku_name" {
  description = "The SKU name for Redis (e.g., Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "redis_family" {
  description = "The SKU family (C for Basic/Standard, P for Premium)."
  type        = string
  default     = "C"
}
variable "vm_size" {
  description = "The size of the VM (e.g., Standard_B1s)."
  type        = string
}

variable "vm_admin_username" {
  description = "Admin username for the VM."
  type        = string
}

variable "vm_admin_password" {
  description = "Admin password for the VM (Windows only)."
  type        = string
  sensitive   = true
}

variable "blob_storage_account_name" {
  description = "Globally unique name for the storage account."
  type        = string
}

variable "blob_storage_account_tier" {
  description = "The tier of the storage account. (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "blob_storage_account_replication_type" {
  description = "The replication type for the storage account. (LRS, GRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "postgresql_sku_name" {
  description = "The SKU name for the PostgreSQL server (e.g., GP_Standard_D2s_v3)."
  type        = string
}

variable "postgresql_storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to use (e.g., 13, 14, 15)."
  type        = string
}
variable "vnet_name" {
  description = "The name of the Azure Virtual Network."
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID to use for the provider."
  type        = string
}
