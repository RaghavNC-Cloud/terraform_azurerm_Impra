output "id" {
  description = "The unique identifier for the Azure Role Assignment."
  value       = { for v in azurerm_role_assignment.this : v.name => v.id }
}

output "name" {
  description = "The name of the Azure Role Assignment."
  value       = { for v in azurerm_role_assignment.this : v.name => v.name }
}

output "principal_id" {
  description = "The ID of the principal (user, group, service principal, or managed identity) to whom the role is assigned."
  value       = { for v in azurerm_role_assignment.this : v.name => v.principal_id }
}

output "role_definition_id" {
  description = "The ID of the Azure Role Definition used in the role assignment."
  value       = { for v in azurerm_role_assignment.this : v.name => v.role_definition_id }
}
