variable "virtual_networks" {
  description = <<-EOF
    Parameters used to create `Azure Virtual Network`

      `name` = (`Required` The name of the Azure Virtual Network.)

      `resource_group_name` = (`Required` The name of the resource group in which to create the Azure Virtual Network.)

      `location` = (`Required` Location of the virtual network. Defaults to `uksouth`)

      `address_space` = (`Required` The address space to use for Azure Virtual Network.)

      'dns_servers` = (`Optional` The DNS Server for Azure Virtual Network. Defaults to MS DNS Server)
  EOF
  type = map(object({
    name                = string
    location            = optional(string, "uksouth")
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
  }))
  default = {}
}

variable "subnets" {
  description = <<-EOF
    Parameters used to create `Subnet`

      `name` = (`Required` The name of the subnet.)

      `address_prefixes` = (`Required` The address prefixes to use for the subnet.)

      `resource_group_name` = (`Required` The name of the resource group in which to create the subnet.)

      `virtual_network_name` = (`Required` The name of the virtual network to which to attach the subnet.)

      `enable_service_delegation` = (`Optional` Enable or disable service delegation on the subnet. Defaults to `false`)

      `service_endpoints` = (`Optional` The list of Service endpoints to associate with the subnet.)

      `private_endpoint_network_policies_enabled` = (`Optional` Enable or Disable network policies for the private endpoint on the subnet. Defaults to `true`)

      `delegation` = (`Optional` A delegation block supports the following.)

      `name` = (`Required` A name for this delegation.)

      `service_delegation` = (`Required` A service_delegation block as defined below.)

      `name` = (`Required` The name of service to delegate to.)

      `actions` = (`Required` A list of Actions which should be delegated.)
  EOF
  type = map(object({
    name                                      = string
    address_prefixes                          = list(string)
    resource_group_name                       = string
    virtual_network_name                      = string
    enable_service_delegation                 = optional(bool, false)
    service_endpoints                         = optional(list(string))
    private_endpoint_network_policies_enabled = optional(bool, true)
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))
  }))
  default = {}
}

variable "nsg_association" {
  description = <<-EOF
    Parameters used to create `NSG Association`

    `network_security_group_id` - (`Required` The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created.)

    `subnet_id` - (`Required` The ID of the Subnet. Changing this forces a new resource to be created.)
    EOF
  type = map(object({
    network_security_group_id = string
    subnet_id                 = string
  }))
  default = {}
}

variable "rt_association" {
  description = <<-EOF
  Parameters used to create `NSG Association`
    `route_table_id` - (`Required` The ID of the Route Table which should be associated with the Subnet. Changing this forces a new resource to be created.)

    `subnet_id` - (`Required` The ID of the Subnet. Changing this forces a new resource to be created.)
  EOF
  type = map(object({
    route_table_id = string
    subnet_id      = string
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
