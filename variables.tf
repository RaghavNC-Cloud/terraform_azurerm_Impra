variable "rgname"{
    type = string
    description = "used for naming resource group"
}

# Variable for Location

variable "location"{
    type = string
    description = "used for selecting location"
    default = "SouthUK"
}

# Variable to Prefix to identify resources

variable "prefix" {
  type = string
  description = "The prefix used for all resources in this example"
}

# Variable to define space address for VNET

variable "vnet_cidr_prefix" {
  type = string
  description = "This variable defines address space for vnet"
}

## Variable for Subnet
variable "subnet1_cidr_prefix" {
  type = string
  description = "This variable defines address space for subnetnet"
}
