output "id" {
  description = "The unique identifier of the Azure Key Vault Access Policy."
  value       = values(azurerm_key_vault_access_policy.this).*.id
}

output "application_id" {
  description = "The Application ID associated with the Azure Key Vault Access Policy."
  value       = values(azurerm_key_vault_access_policy.this).*.application_id
}

output "key_vault_id" {
  description = "The ID of the Azure Key Vault to which the Access Policy is applied."
  value       = values(azurerm_key_vault_access_policy.this).*.key_vault_id
}

output "object_id" {
  description = "The Object ID associated with the Azure Key Vault Access Policy."
  value       = values(azurerm_key_vault_access_policy.this).*.object_id
}
