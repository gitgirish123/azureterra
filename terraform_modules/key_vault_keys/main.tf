resource "azurerm_key_vault_key" "other" {
  for_each     = { for key in var.keys : key.name => key if !contains(["EC", "EC-HSM"], key.key_type) }
  name         = each.value.name
  key_vault_id = var.key_vault_id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts
  # No curve_name here!
}
