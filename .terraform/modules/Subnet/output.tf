output "id" {
  description = "The ID of the Azure Virtual Network."
  value       = { for v in azurerm_virtual_network.this : v.name => v.id }
}

output "name" {
  description = "The name of the Azure Virtual Network."
  value       = { for v in azurerm_virtual_network.this : v.name => v.name }
}

output "resource_group_name" {
  description = "The name of the resource group where the Azure Virtual Network is located."
  value       = { for v in azurerm_virtual_network.this : v.name => v.resource_group_name }
}

output "subnet" {
  description = "The list of subnets within the Azure Virtual Network."
  value       = { for v in azurerm_virtual_network.this : v.name => v.subnet }
}

output "subnet_id" {
  description = "The ID of the Azure Subnet."
  value       = { for v in azurerm_subnet.this : v.name => v.id }
}

output "subnet_name" {
  description = "The name of the Azure Subnet."
  value       = { for v in azurerm_subnet.this : v.name => v.name }
}

output "subnet_virtual_network_name" {
  description = "The name of the Azure Virtual Network associated with the Subnet."
  value       = { for v in azurerm_subnet.this : v.name => v.virtual_network_name }
}

output "subnet_resource_group_name" {
  description = "The name of the resource group where the Azure Subnet is located."
  value       = { for v in azurerm_subnet.this : v.name => v.resource_group_name }
}

output "subnet_service_endpoints" {
  description = "The service endpoints associated with the Subnet."
  value       = { for v in azurerm_subnet.this : v.name => v.service_endpoints }
}
