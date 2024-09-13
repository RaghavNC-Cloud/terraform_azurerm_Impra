
# Create Azure VNet
resource "azurerm_virtual_network" "this" {
  for_each            = var.virtual_networks == null ? {} : var.virtual_networks
  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  address_space       = each.value["address_space"]
  dns_servers         = each.value["dns_servers"]
  tags                = var.tags
}

# Create Subnets in the VNet
resource "azurerm_subnet" "this" {
  for_each             = var.subnets == null ? {} : var.subnets
  name                 = each.value["name"]
  resource_group_name  = each.value["resource_group_name"]
  virtual_network_name = each.value["virtual_network_name"]
  address_prefixes     = each.value["address_prefixes"]
  service_endpoints    = each.value["service_endpoints"]
  dynamic "delegation" {
    for_each = each.value["enable_service_delegation"] == true ? [1] : []
    content {
      name = each.value["delegation"].name
      service_delegation {
        name    = each.value["delegation"]["service_delegation"].name
        actions = each.value["delegation"]["service_delegation"].actions
      }
    }
  }
}

# Create NSG association
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = var.nsg_association != null ? var.nsg_association : {}
  subnet_id                 = each.value.subnet_id
  network_security_group_id = each.value.network_security_group_id
  depends_on                = [azurerm_subnet.this]
}

# Create route table association
resource "azurerm_subnet_route_table_association" "this" {
  for_each       = var.rt_association != null ? var.rt_association : {}
  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
  depends_on     = [azurerm_subnet.this]
}
