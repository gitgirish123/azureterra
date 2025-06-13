variable "name" {
  type        = string
  description = "Name of the Azure Static Web App."
}
variable "resource_group_name" {
  type        = string
  description = "Resource group for the Static Web App."
}
variable "location" {
  type        = string
  description = "Azure region."
}
variable "sku_tier" {
  type        = string
  description = "The SKU tier of the Static Web App. Possible values: Free, Standard."
  default     = "Free"
}
variable "sku_size" {
  type        = string
  description = "The SKU size of the Static Web App. Possible values: Free, Standard."
  default     = "Free"
}
