# Create private endpoint
resource "azurerm_private_endpoint" "this" {
  for_each                      = var.private_endpoints
  name                          = each.value.name
  custom_network_interface_name = "${each.value.name}-nic"
  location                      = each.value.location
  resource_group_name           = each.value["resource_group_name"]
  subnet_id                     = each.value["subnet_id"]
  tags                          = var.tags

  private_dns_zone_group {
    name                 = each.value.name
    private_dns_zone_ids = each.value["private_dns_zone_group"].private_dns_zone_ids

  }

  private_service_connection {
    name                           = "${each.value.name}-pscon"
    private_connection_resource_id = each.value["private_service_connection"].private_connection_resource_id
    is_manual_connection           = each.value["private_service_connection"].is_manual_connection
    subresource_names              = each.value["private_service_connection"].subresource_names
  }
}
