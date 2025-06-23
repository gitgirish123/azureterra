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

apim_publisher_name  = "Your Company Name"
apim_publisher_email = "admin@example.com"

event_grid_topic_name = "my-event-grid-topic"
servicebus_namespace_name = "my-servicebus-namespace"
servicebus_sku           = "Standard"

redis_sku_name = "Standard"
redis_family   = "C"

vm_size             = "Standard_B1s"
vm_admin_username  = "azureuser"
vm_admin_password  = "P@ssw0rd123!"

postgresql_server_name   = "girish-postgres"
postgresql_sku_name      = "GP_Standard_D2s_v3"
postgresql_storage_mb    = 5120
postgresql_version       = "15"

blob_storage_account_name = "girishstorageaccount"

vnet_name = "girish-vnet"
subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
