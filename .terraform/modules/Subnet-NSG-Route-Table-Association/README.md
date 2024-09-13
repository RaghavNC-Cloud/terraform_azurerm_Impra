# Azure Virtual Network

The module allows you to create Azure Virtual Networks or subnets and association of NSG and route tables for subnets. For more info check

*[Virtual Networks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network.html)

*[Subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)

*[Route table association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association)

*[Network security group association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association)

Usage
```
locals {
  nsg_association = {
    0 = {
      subnet_id                 = module.Subnet.subnet_id["<subnet name>"]
      network_security_group_id = data.azurerm_network_security_group.this.id
    }
  }

  rt_association = {
    0 = {
      subnet_id      = module.Databricks-Subnet.subnet_id["<subnet name>"]
      route_table_id = module.RouteTable.route_table_id["<route name>"]
    }
  }
}

module "network" {
  source           = "app.terraform.io/<TFC Org Name>/vnet/azurerm"
  version          = "x.x.x"
  virtual_networks = var.virtual_networks
  subnets          = var.subnets
  tags             = var.tags
}

module "association" {
  source          = "app.terraform.io/<TFC Org Name>/vnet/azurerm"
  version         = "x.x.x"
  nsg_association = local.nsg_association
  rt_association  = local.rt_association
  tags            = var.tags
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nsg_association"></a> [nsg\_association](#input\_nsg\_association) | Parameters used to create `NSG Association`<br><br>`network_security_group_id` - (`Required` The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created.)<br><br>`subnet_id` - (`Required` The ID of the Subnet. Changing this forces a new resource to be created.) | <pre>map(object({<br>    network_security_group_id = string<br>    subnet_id                 = string<br>  }))</pre> | `{}` | no |
| <a name="input_rt_association"></a> [rt\_association](#input\_rt\_association) | Parameters used to create `NSG Association`<br>  `route_table_id` - (`Required` The ID of the Route Table which should be associated with the Subnet. Changing this forces a new resource to be created.)<br><br>  `subnet_id` - (`Required` The ID of the Subnet. Changing this forces a new resource to be created.) | <pre>map(object({<br>    route_table_id = string<br>    subnet_id      = string<br>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Parameters used to create `Subnet`<br><br>  `name` = (`Required` The name of the subnet.)<br><br>  `address_prefixes` = (`Required` The address prefixes to use for the subnet.)<br><br>  `resource_group_name` = (`Required` The name of the resource group in which to create the subnet.)<br><br>  `virtual_network_name` = (`Required` The name of the virtual network to which to attach the subnet.)<br><br>  `enable_service_delegation` = (`Optional` Enable or disable service delegation on the subnet. Defaults to `false`)<br><br>  `service_endpoints` = (`Optional` The list of Service endpoints to associate with the subnet.)<br><br>  `private_endpoint_network_policies_enabled` = (`Optional` Enable or Disable network policies for the private endpoint on the subnet. Defaults to `true`)<br><br>  `delegation` = (`Optional` A delegation block supports the following.)<br><br>  `name` = (`Required` A name for this delegation.)<br><br>  `service_delegation` = (`Required` A service\_delegation block as defined below.)<br><br>  `name` = (`Required` The name of service to delegate to.)<br><br>  `actions` = (`Required` A list of Actions which should be delegated.) | <pre>map(object({<br>    name                                      = string<br>    address_prefixes                          = list(string)<br>    resource_group_name                       = string<br>    virtual_network_name                      = string<br>    enable_service_delegation                 = optional(bool, false)<br>    service_endpoints                         = optional(list(string))<br>    private_endpoint_network_policies_enabled = optional(bool, true)<br>    delegation = optional(object({<br>      name = string<br>      service_delegation = object({<br>        name    = string<br>        actions = optional(list(string))<br>      })<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Parameters used to create `Azure Virtual Network`<br><br>  `name` = (`Required` The name of the Azure Virtual Network.)<br><br>  `resource_group_name` = (`Required` The name of the resource group in which to create the Azure Virtual Network.)<br><br>  `location` = (`Required` Location of the virtual network. Defaults to `uksouth`)<br><br>  `address_space` = (`Required` The address space to use for Azure Virtual Network.)<br><br>  'dns\_servers` = (`Optional` The DNS Server for Azure Virtual Network. Defaults to MS DNS Server)<br>` | <pre>map(object({<br>    name                = string<br>    location            = optional(string, "uksouth")<br>    resource_group_name = string<br>    address_space       = list(string)<br>    dns_servers         = optional(list(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Virtual Network. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Virtual Network. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group where the Azure Virtual Network is located. |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | The list of subnets within the Azure Virtual Network. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the Azure Subnet. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of the Azure Subnet. |
| <a name="output_subnet_resource_group_name"></a> [subnet\_resource\_group\_name](#output\_subnet\_resource\_group\_name) | The name of the resource group where the Azure Subnet is located. |
| <a name="output_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#output\_subnet\_service\_endpoints) | The service endpoints associated with the Subnet. |
| <a name="output_subnet_virtual_network_name"></a> [subnet\_virtual\_network\_name](#output\_subnet\_virtual\_network\_name) | The name of the Azure Virtual Network associated with the Subnet. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->