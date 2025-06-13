output "certificate_ids" {
  value = [for c in azurerm_key_vault_certificate.this : c.id]
}
