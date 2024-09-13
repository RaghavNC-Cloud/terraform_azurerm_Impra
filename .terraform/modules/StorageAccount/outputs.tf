output "storage_account_id" {
  description = "The ID of the Azure Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.id }
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.name }
}

output "storage_account_location" {
  description = "The Azure region where the Storage Account is located."
  value       = { for v in azurerm_storage_account.this : v.name => v.location }
}

output "storage_account_resource_group_name" {
  description = "The name of the resource group containing the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.resource_group_name }
}

output "storage_account_identity" {
  description = "The identity associated with the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.identity }
}

output "identity_principal_id" {
  description = "The principal ID(s) associated with the identity of the storage account."
  value = {
    for k, v in azurerm_storage_account.this : k => join(",", v.identity.*.principal_id)
  }
}

output "storage_account_primary_access_key" {
  description = "The primary access key of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.primary_access_key }
  sensitive   = true
}

output "storage_account_primary_blob_connection_string" {
  description = "The connection string for accessing the primary blob service of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.primary_blob_connection_string }
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The connection string for accessing the primary service of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.primary_connection_string }
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  description = "The secondary access key of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.secondary_access_key }
  sensitive   = true
}

output "storage_account_secondary_blob_connection_string" {
  description = "The connection string for accessing the secondary blob service of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.secondary_blob_connection_string }
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  description = "The connection string for accessing the secondary service of the Storage Account."
  value       = { for v in azurerm_storage_account.this : v.name => v.secondary_connection_string }
  sensitive   = true
}

output "storage_share_id" {
  description = "The ID of the Azure Storage Share."
  value       = { for v in azurerm_storage_share.this : v.name => v.id }
}

output "storage_share_name" {
  description = "The name of the Azure Storage Share."
  value       = { for v in azurerm_storage_share.this : v.name => v.name }
}

output "storage_share_storage_account_name" {
  description = "The name of the Azure Storage Account associated with the Storage Share."
  value       = { for v in azurerm_storage_share.this : v.name => v.storage_account_name }
}

output "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Azure Storage Data Lake Gen2 Filesystem."
  value       = { for v in azurerm_storage_data_lake_gen2_filesystem.this : v.name => v.id }
}

output "storage_data_lake_gen2_filesystem_name" {
  description = "The name of the Azure Storage Data Lake Gen2 Filesystem."
  value       = { for v in azurerm_storage_data_lake_gen2_filesystem.this : v.name => v.name }
}

output "storage_data_lake_gen2_filesystem_storage_account_id" {
  description = "The ID of the Azure Storage Account associated with the Data Lake Gen2 Filesystem."
  value       = { for v in azurerm_storage_data_lake_gen2_filesystem.this : v.name => v.storage_account_id }
}

output "storage_container_id" {
  description = "The ID of the Azure Storage Container."
  value       = { for v in azurerm_storage_container.this : "${v.name}-${v.storage_account_name}" => v.id }
}

output "storage_container_name" {
  description = "The name of the Azure Storage Container."
  value       = { for v in azurerm_storage_container.this : "${v.name}-${v.storage_account_name}" => v.name }
}
