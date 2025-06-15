resource "azurerm_key_vault_key" "this" {
  for_each     = { for key in var.keys : key.name => key }
  name         = each.value.name
  key_vault_id = var.key_vault_id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts
  
}
