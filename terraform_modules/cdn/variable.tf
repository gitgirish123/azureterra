variable "resource_group_name" {
  type        = string
  description = "Resource group for CDN."
}
variable "sku" {
  type        = string
  default     = "Standard_Microsoft"
  description = "CDN SKU."
}
variable "origin_host_header" {
  type        = string
  description = "Host header for CDN origin."
}
