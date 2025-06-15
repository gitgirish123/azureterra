variable "key_vault_id" {
  type = string
}
variable "keys" {
  type = list(object({
    name      = string
    key_type  = string
    key_size  = number
    key_opts  = list(string)
  }))
}
