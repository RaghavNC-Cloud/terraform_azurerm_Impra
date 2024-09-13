output "id" {
  description = "A list of unique identifiers for the Azure Resource Groups."
  value       = { for v in azurerm_resource_group.this : v.name => v.id }
}

output "name" {
  description = "A list of names of the Azure Resource Groups."
  value       = { for v in azurerm_resource_group.this : v.name => v.name }
}

output "location" {
  description = "A list of locations (regions) where the Azure Resource Groups are created."
  value       = { for v in azurerm_resource_group.this : v.name => v.location }
}
