resource "azurerm_eventgrid_topic" "this" {
  name                = var.topic_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
