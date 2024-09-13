output "private_endpoint_id" {
  description = "The unique identifier(s) of the Azure Private Endpoint(s)."
  value       = { for v in azurerm_private_endpoint.this : v.name => v.id }
}

output "private_endpoint_name" {
  description = "The name(s) of the Azure Private Endpoint(s)."
  value       = { for v in azurerm_private_endpoint.this : v.name => v.name }
}

output "private_endpoint_resource_group_name" {
  description = "The name of the Azure resource group in which the Private Endpoint(s) is located."
  value       = { for v in azurerm_private_endpoint.this : v.name => v.resource_group_name }
}

output "private_endpoint_private_ip_address" {
  description = "The private IP address(es) associated with the Private Endpoint(s)."
  value = flatten([
    for connections in azurerm_private_endpoint.this : [
      for connection in connections.private_service_connection : connection.private_ip_address
    ]
  ])
}

output "private_endpoint_fqdn" {
  description = "The fully qualified domain name(s) of the Azure Private Endpoint(s)."
  value = flatten([
    for connections in azurerm_private_endpoint.this : [
      for connection in connections.private_service_connection : connection.private_connection_resource_id
    ]
  ])
}

output "private_endpoint_fqdn_with_https" {
  description = "The fully qualified domain name(s) of the Azure Private Endpoint(s) with https://."
  value = flatten([
    for connections in azurerm_private_endpoint.this : [
      for connection in connections.private_service_connection : "https://${connection.private_connection_resource_id}"
    ]
  ])
}
