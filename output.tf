output "resource_group_name" {
  description = "The name of the created resource group."
  value       = module.resource_group.name
}

output "vnet_id" {
  description = "The ID of the created Virtual Network."
  value       = module.vnet.id
}

output "dns_zone_id" {
  description = "The ID of the Azure DNS Zone."
  value       = module.dns.id
}

output "cdn_endpoint" {
  description = "The endpoint of the Azure CDN."
  value       = module.cdn.endpoint
}

output "api_management_name" {
  description = "The name of the API Management instance."
  value       = module.api_management.name
}

output "load_balancer_id" {
  description = "The ID of the Load Balancer."
  value       = module.load_balancer.id
}

output "vm_ids" {
  description = "The IDs of the deployed Virtual Machines."
  value       = module.virtual_machine.vm_ids
}

output "static_web_app_url" {
  description = "The default hostname of the Azure Static Web App."
  value       = module.static_web_app.default_hostname
}

output "blob_storage_account_name" {
  description = "The name of the Blob Storage account."
  value       = module.blob_storage.account_name
}

output "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  value       = module.key_vault.id
}

output "key_vault_certificate_ids" {
  description = "The IDs of the Key Vault certificates."
  value       = module.key_vault_certificates.certificate_ids
}

output "key_vault_key_ids" {
  description = "The IDs of the Key Vault keys."
  value       = module.key_vault_keys.key_ids
}

output "service_bus_namespace_id" {
  description = "The ID of the Service Bus namespace."
  value       = module.service_bus.namespace_id
}

output "event_grid_topic_id" {
  description = "The ID of the Event Grid topic."
  value       = module.event_grid.eventgrid_topic_id
}

output "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  value       = module.postgresql.server_name
}

output "redis_host_name" {
  description = "The hostname of the Redis Cache."
  value       = module.redis_cache.redis_host_name
}

output "monitor_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  value       = module.monitor.workspace_id
}
