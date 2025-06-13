output "key_ids" {
  value = [for k in azurerm_key_vault_key.this : k.id]
}
