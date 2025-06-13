variable "key_vault_id" { type = string }
variable "certificates" {
  type = list(object({
    name     = string
    contents = string
    password = string
  }))
}
