resource_group_name    = "my-azure-rg"
location              = "East US"

address_space         = ["10.1.0.0/16"]

dns_zone_name         = "example.com"

apim_sku_name         = "Consumption_0"

vm_count              = 2

static_web_app_name   = "my-static-web-app"

certificates = [
  {
    name     = "my-cert"
    contents = "BASE64_ENCODED_CERTIFICATE"
    password = "cert-password"
  }
]

keys = [
  {
    name        = "my-key"
    key_type    = "RSA"
    key_size    = 2048
    key_opts    = ["encrypt", "decrypt"]
    curve_name  = ""
  }
]

postgres_admin_username = "pgadmin"
postgres_admin_password = "SuperSecretPassword123!"

redis_capacity = 2
