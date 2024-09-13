output "id" {
  description = "The unique identifier(s) of the Azure Key Vault(s)."
  value       = { for v in azurerm_key_vault.this : v.name => v.id }
}

output "name" {
  description = "The name(s) of the Azure Key Vault(s)."
  value       = { for v in azurerm_key_vault.this : v.name => v.name }
}

output "resource_group_name" {
  description = "The name of the Azure resource group in which the Azure Key Vault(s) is located."
  value       = { for v in azurerm_key_vault.this : v.name => v.resource_group_name }
}

output "tenant_id" {
  description = "The tenant ID associated with the Azure Key Vault(s)."
  value       = { for v in azurerm_key_vault.this : v.name => v.tenant_id }
}

output "vault_uri" {
  description = "The URI(s) of the Azure Key Vault(s)."
  value       = { for v in azurerm_key_vault.this : v.name => v.vault_uri }
}
