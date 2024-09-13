variable "network_interface" {
  description = <<-EOF
    Parameters used to create `Network Interface`

      `name` = (`Required` The name of the Network Interface.)

      `location` = (`Required` The location where the Network Interface should exist. Defaults to `uksouth`)

      `resource_group_name` = (`Required` The name of the resource group in which to create the subnet.s)

      `enable_ip_forwarding` = (`Optional` Should IP Forwarding be enabled? Defaults to `False`)

      `enable_accelerated_networking` = (`Optional` Should Accelerated Networking be enabled? Defaults to `False`)

      `internal_dns_name_label` = (`Optional` The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.)

      `dns_servers` = (`Optional` A list of IP Addresses defining the DNS Servers which should be used for this Network Interface.)

      `ip_configuration` = (`Required` The IP configuration settings for the Network Interface.)

      `name` = (`Required` A name used for this IP Configuration.)

      `vnet_resource_group_name` = (`Optional` The name of the resource group containing the Vnet.)

      `virtual_network_name` = (`Optional` The name of the virtual network containing the subnet.)

      `subnet_name` = (`Optional` The name of the subnet.)

      `enable_lb_frontend` = (`Optional` Enable or disable load balancer frontend IP for the VM. Defaults to `false`)

      `primary` = (`Optional` Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to `false`.)

      `enable_public_ip_address` = (`Optional` Enable or disable public IP for the VM. Defaults to `false`)

      `public_ip_resource_group_name` = (`Optional` The name of the resource group containing the public ip address to associate with the VM.)

      `public_ip_name` = (`Optional` The name of the public IP to associate with the VM.)

      `private_ip_address_allocation` = (`Required` The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`)

      `private_ip_address` = (`Optional` The Static IP Address which should be used.)

      `private_ip_address_version` = (`Optional` The IP Version to use. Possible values are IPv4 or IPv6. Defaults to `IPv4`.)
  EOF
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    enable_ip_forwarding          = optional(bool)
    enable_accelerated_networking = optional(bool)
    internal_dns_name_label       = optional(string)
    dns_servers                   = optional(set(string))
    ip_configuration = map(object({
      name                          = string
      vnet_resource_group_name      = optional(string)
      virtual_network_name          = optional(string)
      subnet_name                   = optional(string)
      enable_lb_frontend            = optional(bool, false)
      primary                       = optional(bool)
      enable_public_ip_address      = optional(bool, false)
      public_ip_resource_group_name = optional(string)
      public_ip_name                = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address            = optional(string)
      private_ip_address_version    = optional(string, "IPv4")
    }))
  }))
  default = {}
}

variable "windows_vms" {
  description = <<-EOF
    Parameters used to create `Azure Windows Virtual Machine`

      `name` = (`Required` The name of the Virtual Machine.)

      `computer_name` = (`Required` The computer name of the Virtual Machine.)

      `location` = (`Optional` The Azure region where the Virtual Machine will be created. Defaults to `uksouth`)

      `resource_group_name` = (`Required` The name of the resource group in which to create the Virtual Machine.)

      `size` = (`Required` The size of the Virtual Machine.)

      `admin_username` = (`Required` The admin username for the Virtual Machine.)

      `zone` = (`Optional` Specifies the Availability Zones in which this Windows Virtual Machine should be located.)

      `user_data` = (`Optional` The Base64-Encoded User Data which should be used for this Virtual Machine.

      `custom_data` = (`Optional` The Base64-Encoded Custom Data which should be used for this Virtual Machine.

      `eviction_policy` = (`Optional` Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance.

      `extensions_time_budget` = (`Optional` Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to `90` minutes (`PT1H30M`).

      `hotpatching_enabled` = (`Optional` Should the VM be patched without requiring a reboot? Possible values are true or false. Defaults to `false`.

      `license_type` = (`Optional` Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are `None`, `Windows_Client` and `Windows_Server`.

      `max_bid_price` = (`Optional` The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons.

      `priority` = (`Optional` Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Defaults to `Regular`.

      `secure_boot_enabled` = (`Optional` Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine.

      `timezone` = (`Optional` Specifies the Time Zone which should be used by the Virtual Machine. Defaults to `GMT Standard Time`

      `ou_path` = (`Required` The OU location on Active directory. Valid values are `ou_2016`, `ou_2019`, `ou_2022`)

      `provision_vm_agent` = (`Optional` Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to `true`)

      `marketplace_image` = (`Optional` Is the VM Image from Azure Marketplace? Defaults to `false`)

      `allow_extension_operations` = (`Optional` Should Extension Operations be allowed on this Virtual Machine?  Defaults to `true`)

      `patch_mode` = (`Optional` Specifies the mode of in-guest patching to this Windows Virtual Machine. Defaults to `AutomaticByPlatform`)

      `patch_assessment_mode` = (`Optional` Specifies the mode of VM Guest Patching for the Virtual Machine. Defaults to `AutomaticByPlatform`)

      `identity` = (`Optional` Identity configuration for VM.)

      `type` = (`Required` Type of Managed Identity. Defaults to `SystemAssigned`)

      `username` = (`Required` The Username for which this Public SSH Key should be configured.)

      `os_disk` = (`Required` The OS disk settings for the Virtual Machine.)

      `caching` = (`Optional` The caching type for the OS disk. Defaults to `ReadWrite`)

      `storage_account_type` = (`Optional` The storage account type for the OS disk. Defaults to `Standard_LRS`)

      `disk_size_gb` = (`Optional` The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.)

      `write_accelerator_enabled` - (`Optional` Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`.)

      `source_image_reference` = (`Required` The source image reference for the Virtual Machine.)

      `publisher` = (`Required` The publisher of the source image.)

      `offer` = (`Required` The offer of the source image.)

      `sku` = (`Required` The SKU of the source image.)

      `version` = (`Required` The version of the source image.)

      `boot_diagnostics` = (`Optional` A boot_diagnostics block supports the following)

      `storage_account_name` = (`Required` Name of the storage account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.)

      `extra_tags` = (`Optional` Additional tags to add to default tags.)
  EOF
  type = map(object({
    name                       = string
    computer_name              = string
    location                   = optional(string, "uksouth")
    resource_group_name        = string
    network_interface_ids      = set(string)
    size                       = string
    admin_username             = string
    zone                       = optional(number)
    user_data                  = optional(string)
    custom_data                = optional(string)
    patch_mode                 = optional(string, "AutomaticByPlatform")
    patch_assessment_mode      = optional(string, "AutomaticByPlatform")
    allow_extension_operations = optional(bool, true)
    provision_vm_agent         = optional(bool, true)
    marketplace_image          = optional(bool, false)
    eviction_policy            = optional(string)
    extensions_time_budget     = optional(string)
    hotpatching_enabled        = optional(bool)
    license_type               = optional(string)
    max_bid_price              = optional(number)
    priority                   = optional(string)
    secure_boot_enabled        = optional(bool)
    timezone                   = optional(string, "GMT Standard Time")
    ou_path                    = string
    extra_tags                 = optional(map(string))

    identity = optional(object({
      type = string
    }))

    boot_diagnostics = optional(object({
      storage_account_name = string
    }))

    os_disk = object({
      caching                   = optional(string, "ReadWrite")
      storage_account_type      = optional(string, "Standard_LRS")
      disk_size_gb              = optional(number)
      write_accelerator_enabled = optional(bool)
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))

  validation {
    condition     = alltrue([for v in var.windows_vms : contains(["ou_2016", "ou_2019", "ou_2022"], v.ou_path)])
    error_message = "valid values are 'ou_2016', 'ou_2019', 'ou_2022'"
  }
  default = null
}

variable "managed_disk_config" {
  description = <<-EOF
    Parameters used to create `Azure managed disk`

      `name` = (`Required` Specifies the name of the Managed Disk.)

      `storage_account_type` = (`Required` The type of storage to use for the managed disk. Defaults to `Standard_LRS`)

      `location` = (`Required` Specified the supported Azure location where the resource exists., Defaults to `uksouth`)

      `resource_group_name` = (`Required` The name of the Resource Group where the Managed Disk should exist.)

      `create_option` = (`Required` The method to use when creating the managed disk. Defaults to `Empty`)

      `zone` = (`Optional` Specifies the Availability Zone in which this Managed Disk should be located.)

      `disk_size_gb` = (`Optional` Specifies the size of the managed disk to create in gigabytes.)
  EOF
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = optional(string, "uksouth")
    storage_account_type = optional(string, "Standard_LRS")
    create_option        = optional(string, "Empty")
    zone                 = optional(number)
    disk_size_gb         = optional(number)
  }))
  default = null
}

variable "disk_attachment" {
  description = <<-EOF
    Parameters used to configure `Disk Attachment`

      `disk_resource_group_name` - (`Required`) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created.)

      `disk_name` - (`Required`) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created.)

      `vm_resource_group_name` - (`Required`) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created.)

      `vm_name` - (`Required`) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created.)

      `lun` - (`Required`) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created.)

      `caching` - (`Required`) Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite. Defaults to `ReadWrite`)

      `create_option` - (`Optional`) The Create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created.)

      `write_accelerator_enabled` - (`Optional`) Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs. Defaults to `false`.)
  EOF
  type = map(object({
    disk_resource_group_name  = string
    disk_name                 = string
    vm_resource_group_name    = string
    vm_name                   = string
    lun                       = number
    caching                   = optional(string, "ReadWrite")
    create_option             = optional(string)
    write_accelerator_enabled = optional(bool)
  }))
  default = null
}

variable "source_resource_id" {
  description = "The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or the recovery point to restore when create_option is Restore."
  type        = string
  default     = null
}

variable "user_assigned_identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to MSSQL server."
  type        = list(string)
  default     = null
}

variable "tf_ad_domain_variables" {
  description = "Domain join account name, OU path and domain name"
  type        = map(string)
}

variable "domain_account_password" {
  description = "Domain join account password"
  type        = string
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
}

variable "tags" {
  description = "Tag variable"
  type        = map(string)
}
