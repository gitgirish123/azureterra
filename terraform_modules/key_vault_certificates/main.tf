resource "azurerm_key_vault_certificate" "this" {
  for_each      = { for cert in var.certificates : cert.name => cert }
  name          = each.value.name
  key_vault_id  = var.key_vault_id

  certificate {
    contents = each.value.contents
    password = each.value.password
  }
}
