output "resource_id" {
  description = "The resource ID of the Azure Key Vault Secret."
  value       = { for v in azurerm_key_vault_secret.this : v.name => v.resource_id }
}

output "id" {
  description = "The ID of the Azure Key Vault Secret."
  value       = { for v in azurerm_key_vault_secret.this : v.name => v.id }
}

output "name" {
  description = "The name of the Azure Key Vault Secret."
  value       = { for v in azurerm_key_vault_secret.this : v.name => v.name }
}

output "secret_value" {
  description = "The value of the Azure Key Vault Secret."
  value       = { for v in azurerm_key_vault_secret.this : v.name => v.value }
  sensitive   = true
}
