resource "azurerm_cdn_profile" "this" {
  name                = "${var.resource_group_name}-cdn"
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = var.sku
}

resource "azurerm_cdn_endpoint" "this" {
  name                = "${var.resource_group_name}-endpoint"
  profile_name        = azurerm_cdn_profile.this.name
  resource_group_name = var.resource_group_name
  location            = "global"
  origin_host_header  = var.origin_host_header
  origin {
    name      = "origin"
    host_name = var.origin_host_header
  }
}
