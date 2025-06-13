resource "azurerm_static_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_tier = var.sku_tier   # e.g., "Free" or "Standard"
  sku_size = var.sku_size   # e.g., "Free" or "Standard"
}
