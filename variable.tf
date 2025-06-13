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
