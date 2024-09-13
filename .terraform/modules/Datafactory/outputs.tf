output "data_factory_id" {
  description = "Azure Datafactory ID"
  value       = { for v in azurerm_data_factory.this : v.name => v.id }
}

output "data_factory_identity" {
  description = "Azure datafactory identity"
  value       = { for v in azurerm_data_factory.this : v.name => v.identity }
}

output "data_factory_principal_id" {
  description = "Type of managed identity"
  value = {
    for k, v in azurerm_data_factory.this : k => join(",", v.identity.*.principal_id)
  }
}

output "data_factory_name" {
  description = "Azure Datafactory name"
  value       = { for v in azurerm_data_factory.this : v.name => v.name }
}

output "data_factory_integration_runtime_azure_ssis_id" {
  description = "The ID of the Data Factory Azure-SSIS Integration Runtime."
  value       = { for v in azurerm_data_factory_integration_runtime_azure_ssis.this : v.name => v.id }
}

output "data_factory_integration_runtime_self_hosted_id" {
  description = "The ID of the Data Factory Self Hosted Integration Runtime."
  value       = { for v in azurerm_data_factory_integration_runtime_self_hosted.this : v.name => v.id }
}

output "data_factory_integration_runtime_azure_id" {
  description = "The ID of the Data Factory Azure Integration Runtime."
  value       = { for v in azurerm_data_factory_integration_runtime_azure.this : v.name => v.id }
}

output "data_factory_integration_runtime_self_hosted_primary_authorization_key" {
  description = "The primary integration runtime authentication key."
  value       = { for v in azurerm_data_factory_integration_runtime_self_hosted.this : v.name => v.primary_authorization_key }
  sensitive   = true
}

output "data_factory_integration_runtime_self_hosted_secondary_authorization_key" {
  description = "The secondary integration runtime authentication key."
  value       = { for v in azurerm_data_factory_integration_runtime_self_hosted.this : v.name => v.secondary_authorization_key }
  sensitive   = true
}
