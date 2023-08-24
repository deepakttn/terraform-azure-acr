output "registry_id" {
  description = "The ID of the Container Registry."
  value       = module.acr.registry_id
}

output "registry_name" {
  description = "The name of the Container Registry."
  value       = module.acr.registry_name
}

output "registry_login_server" {
  description = "The login server of the Container Registry."
  value       = module.acr.registry_login_server
}

output "registry_admin_username" {
  description = "The admin username of the Container Registry."
  value       = module.acr.registry_admin_username
}

output "registry_admin_password" {
  description = "The admin username of the Container Registry."
  sensitive   = true
  value       = module.acr.registry_admin_password
}

output "sku" {
  description = "The SKU tier for the Container Registry."
  value       = module.acr.sku
}