# Azure Windows Virtual Machine

The module allows you to create one or multiple Azure Windows VMs and related resources. For more information on creating Windows VMs and related resources, please refer to:

[Azure Virtual Machines](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/windows_virtual_machine.html).
[Azure Network Interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/network_interface).
[Azure Managed Disk](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/managed_disk).
[Azure Virtual Machine Extension](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/virtual_machine_extension).

## Usage
```
locals {
  windows_vms = {
    0 = {
      name                  = "dev-udp-sla-001-vm"
      computer_name         = "devudpslavm"
      resource_group_name   = "dev-udp-sla-001-rg"
      size                  = "Standard_D4s_v3"
      admin_username        = "udpadmin"
      ou_path               = "ou_2022"
      zone                  = 1
      disk_size_gb          = 256
      network_interface_ids = [module.virtual-machine-windows.nic_id["<network interface name>"]]

      extra_tags = {
        patch_day_windows = "Tuesday"
        os                = "Windows"
      }

      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter"
        version   = "latest"
      }
      os_disk = {
        storage_account_type = "Premium_LRS"
      }
    }
  }

  managed_disk_config = {
    0 = {
      name                = "dev-udp-sla-001-vm-disk0"
      resource_group_name = "dev-udp-sla-001-rg"
      disk_size_gb        = 30
    }
    1 = {
      name                = "dev-udp-sla-001-vm-disk1"
      resource_group_name = "dev-udp-sla-001-rg"
      disk_size_gb        = 40
    }
  }

  disk_attachment = {
    0 = {
      disk_resource_group_name = "dev-udp-sla-001-rg"
      disk_name                = "dev-udp-sla-001-vm-disk0"
      vm_resource_group_name   = "dev-udp-sla-001-rg"
      vm_name                  = "dev-udp-sla-001-vm"
      lun                      = 1
    }
    1 = {
      disk_resource_group_name = "dev-udp-sla-001-rg"
      disk_name                = "dev-udp-sla-001-vm-disk1"
      vm_resource_group_name   = "dev-udp-sla-001-rg"
      vm_name                  = "dev-udp-sla-001-vm"
      lun                      = 2
    }
  }
}

data "azurerm_client_config" "current" {}

module "virtual-machine-windows" {
  source                  = "app.terraform.io/<TFC Organization Name>/virtual-machine-windows/azurerm"
  version                 = "x.x.x"
  windows_vms             = local.windows_vms
  network_interface       = local.network_interface
  azurerm_client_config   = data.azurerm_client_config.current
  domain_account_password = var.domain_account_password
  tf_ad_domain_variables  = var.tf_ad_domain_variables
  managed_disk_config     = local.managed_disk_config
  disk_attachment         = local.disk_attachment
  tags                    = var.tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_managed_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.domjoin](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.vm_extension](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/windows_virtual_machine) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_client_config"></a> [azurerm\_client\_config](#input\_azurerm\_client\_config) | AzureRM provider configuration | `any` | n/a | yes |
| <a name="input_disk_attachment"></a> [disk\_attachment](#input\_disk\_attachment) | Parameters used to configure `Disk Attachment`<br><br>  `disk_resource_group_name` - (`Required`) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created.)<br><br>  `disk_name` - (`Required`) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created.)<br><br>  `vm_resource_group_name` - (`Required`) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created.)<br><br>  `vm_name` - (`Required`) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created.)<br><br>  `lun` - (`Required`) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created.)<br><br>  `caching` - (`Required`) Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite. Defaults to `ReadWrite`)<br><br>  `create_option` - (`Optional`) The Create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created.)<br><br>  `write_accelerator_enabled` - (`Optional`) Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs. Defaults to `false`.) | <pre>map(object({<br>    disk_resource_group_name  = string<br>    disk_name                 = string<br>    vm_resource_group_name    = string<br>    vm_name                   = string<br>    lun                       = number<br>    caching                   = optional(string, "ReadWrite")<br>    create_option             = optional(string)<br>    write_accelerator_enabled = optional(bool)<br>  }))</pre> | `null` | no |
| <a name="input_domain_account_password"></a> [domain\_account\_password](#input\_domain\_account\_password) | Domain join account password | `string` | n/a | yes |
| <a name="input_managed_disk_config"></a> [managed\_disk\_config](#input\_managed\_disk\_config) | Parameters used to create `Azure managed disk`<br><br>  `name` = (`Required` Specifies the name of the Managed Disk.)<br><br>  `storage_account_type` = (`Required` The type of storage to use for the managed disk. Defaults to `Standard_LRS`)<br><br>  `location` = (`Required` Specified the supported Azure location where the resource exists., Defaults to `uksouth`)<br><br>  `resource_group_name` = (`Required` The name of the Resource Group where the Managed Disk should exist.)<br><br>  `create_option` = (`Required` The method to use when creating the managed disk. Defaults to `Empty`)<br><br>  `zone` = (`Optional` Specifies the Availability Zone in which this Managed Disk should be located.)<br><br>  `disk_size_gb` = (`Optional` Specifies the size of the managed disk to create in gigabytes.) | <pre>map(object({<br>    name                 = string<br>    resource_group_name  = string<br>    location             = optional(string, "uksouth")<br>    storage_account_type = optional(string, "Standard_LRS")<br>    create_option        = optional(string, "Empty")<br>    zone                 = optional(number)<br>    disk_size_gb         = optional(number)<br>  }))</pre> | `null` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Parameters used to create `Network Interface`<br><br>  `name` = (`Required` The name of the Network Interface.)<br><br>  `location` = (`Required` The location where the Network Interface should exist. Defaults to `uksouth`)<br><br>  `resource_group_name` = (`Required` The name of the resource group in which to create the subnet.s)<br><br>  `enable_ip_forwarding` = (`Optional` Should IP Forwarding be enabled? Defaults to `False`)<br><br>  `enable_accelerated_networking` = (`Optional` Should Accelerated Networking be enabled? Defaults to `False`)<br><br>  `internal_dns_name_label` = (`Optional` The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.)<br><br>  `dns_servers` = (`Optional` A list of IP Addresses defining the DNS Servers which should be used for this Network Interface.)<br><br>  `ip_configuration` = (`Required` The IP configuration settings for the Network Interface.)<br><br>  `name` = (`Required` A name used for this IP Configuration.)<br><br>  `vnet_resource_group_name` = (`Optional` The name of the resource group containing the Vnet.)<br><br>  `virtual_network_name` = (`Optional` The name of the virtual network containing the subnet.)<br><br>  `subnet_name` = (`Optional` The name of the subnet.)<br><br>  `enable_lb_frontend` = (`Optional` Enable or disable load balancer frontend IP for the VM. Defaults to `false`)<br><br>  `primary` = (`Optional` Is this the Primary IP Configuration? Must be true for the first ip\_configuration when multiple are specified. Defaults to `false`.)<br><br>  `enable_public_ip_address` = (`Optional` Enable or disable public IP for the VM. Defaults to `false`)<br><br>  `public_ip_resource_group_name` = (`Optional` The name of the resource group containing the public ip address to associate with the VM.)<br><br>  `public_ip_name` = (`Optional` The name of the public IP to associate with the VM.)<br><br>  `private_ip_address_allocation` = (`Required` The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`. Defaults to `Dynamic`)<br><br>  `private_ip_address` = (`Optional` The Static IP Address which should be used.)<br><br>  `private_ip_address_version` = (`Optional` The IP Version to use. Possible values are IPv4 or IPv6. Defaults to `IPv4`.) | <pre>map(object({<br>    name                          = string<br>    location                      = string<br>    resource_group_name           = string<br>    enable_ip_forwarding          = optional(bool)<br>    enable_accelerated_networking = optional(bool)<br>    internal_dns_name_label       = optional(string)<br>    dns_servers                   = optional(set(string))<br>    ip_configuration = map(object({<br>      name                          = string<br>      vnet_resource_group_name      = optional(string)<br>      virtual_network_name          = optional(string)<br>      subnet_name                   = optional(string)<br>      enable_lb_frontend            = optional(bool, false)<br>      primary                       = optional(bool)<br>      enable_public_ip_address      = optional(bool, false)<br>      public_ip_resource_group_name = optional(string)<br>      public_ip_name                = optional(string)<br>      private_ip_address_allocation = optional(string, "Dynamic")<br>      private_ip_address            = optional(string)<br>      private_ip_address_version    = optional(string, "IPv4")<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_source_resource_id"></a> [source\_resource\_id](#input\_source\_resource\_id) | The ID of an existing Managed Disk or Snapshot to copy when create\_option is Copy or the recovery point to restore when create\_option is Restore. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag variable | `map(string)` | n/a | yes |
| <a name="input_tf_ad_domain_variables"></a> [tf\_ad\_domain\_variables](#input\_tf\_ad\_domain\_variables) | Domain join account name, OU path and domain name | `map(string)` | n/a | yes |
| <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to MSSQL server. | `list(string)` | `null` | no |
| <a name="input_windows_vms"></a> [windows\_vms](#input\_windows\_vms) | Parameters used to create `Azure Windows Virtual Machine`<br><br>  `name` = (`Required` The name of the Virtual Machine.)<br><br>  `computer_name` = (`Required` The computer name of the Virtual Machine.)<br><br>  `location` = (`Optional` The Azure region where the Virtual Machine will be created. Defaults to `uksouth`)<br><br>  `resource_group_name` = (`Required` The name of the resource group in which to create the Virtual Machine.)<br><br>  `size` = (`Required` The size of the Virtual Machine.)<br><br>  `admin_username` = (`Required` The admin username for the Virtual Machine.)<br><br>  `zone` = (`Optional` Specifies the Availability Zones in which this Windows Virtual Machine should be located.)<br><br>  `user_data` = (`Optional` The Base64-Encoded User Data which should be used for this Virtual Machine.<br><br>  `custom_data` = (`Optional` The Base64-Encoded Custom Data which should be used for this Virtual Machine.<br><br>  `eviction_policy` = (`Optional` Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance.<br><br>  `extensions_time_budget` = (`Optional` Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to `90` minutes (`PT1H30M`).<br><br>  `hotpatching_enabled` = (`Optional` Should the VM be patched without requiring a reboot? Possible values are true or false. Defaults to `false`.<br><br>  `license_type` = (`Optional` Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are `None`, `Windows_Client` and `Windows_Server`.<br><br>  `max_bid_price` = (`Optional` The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction\_policy. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons.<br><br>  `priority` = (`Optional` Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Defaults to `Regular`.<br><br>  `secure_boot_enabled` = (`Optional` Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine.<br><br>  `timezone` = (`Optional` Specifies the Time Zone which should be used by the Virtual Machine. Defaults to `GMT Standard Time`<br><br>  `ou_path` = (`Required` The OU location on Active directory. Valid values are `ou_2016`, `ou_2019`, `ou_2022`)<br><br>  `provision_vm_agent` = (`Optional` Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to `true`)<br><br>  `marketplace_image` = (`Optional` Is the VM Image from Azure Marketplace? Defaults to `false`)<br><br>  `allow_extension_operations` = (`Optional` Should Extension Operations be allowed on this Virtual Machine?  Defaults to `true`)<br><br>  `patch_mode` = (`Optional` Specifies the mode of in-guest patching to this Windows Virtual Machine. Defaults to `AutomaticByPlatform`)<br><br>  `patch_assessment_mode` = (`Optional` Specifies the mode of VM Guest Patching for the Virtual Machine. Defaults to `AutomaticByPlatform`)<br><br>  `identity` = (`Optional` Identity configuration for VM.)<br><br>  `type` = (`Required` Type of Managed Identity. Defaults to `SystemAssigned`)<br><br>  `username` = (`Required` The Username for which this Public SSH Key should be configured.)<br><br>  `os_disk` = (`Required` The OS disk settings for the Virtual Machine.)<br><br>  `caching` = (`Optional` The caching type for the OS disk. Defaults to `ReadWrite`)<br><br>  `storage_account_type` = (`Optional` The storage account type for the OS disk. Defaults to `Standard_LRS`)<br><br>  `disk_size_gb` = (`Optional` The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.)<br><br>  `write_accelerator_enabled` - (`Optional` Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`.)<br><br>  `source_image_reference` = (`Required` The source image reference for the Virtual Machine.)<br><br>  `publisher` = (`Required` The publisher of the source image.)<br><br>  `offer` = (`Required` The offer of the source image.)<br><br>  `sku` = (`Required` The SKU of the source image.)<br><br>  `version` = (`Required` The version of the source image.)<br><br>  `boot_diagnostics` = (`Optional` A boot\_diagnostics block supports the following)<br><br>  `storage_account_name` = (`Required` Name of the storage account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.)<br><br>  `extra_tags` = (`Optional` Additional tags to add to default tags.) | <pre>map(object({<br>    name                       = string<br>    computer_name              = string<br>    location                   = optional(string, "uksouth")<br>    resource_group_name        = string<br>    network_interface_ids      = set(string)<br>    size                       = string<br>    admin_username             = string<br>    zone                       = optional(number)<br>    user_data                  = optional(string)<br>    custom_data                = optional(string)<br>    patch_mode                 = optional(string, "AutomaticByPlatform")<br>    patch_assessment_mode      = optional(string, "AutomaticByPlatform")<br>    allow_extension_operations = optional(bool, true)<br>    provision_vm_agent         = optional(bool, true)<br>    marketplace_image          = optional(bool, false)<br>    eviction_policy            = optional(string)<br>    extensions_time_budget     = optional(string)<br>    hotpatching_enabled        = optional(bool)<br>    license_type               = optional(string)<br>    max_bid_price              = optional(number)<br>    priority                   = optional(string)<br>    secure_boot_enabled        = optional(bool)<br>    timezone                   = optional(string, "GMT Standard Time")<br>    ou_path                    = string<br>    extra_tags                 = optional(map(string))<br><br>    identity = optional(object({<br>      type = string<br>    }))<br><br>    boot_diagnostics = optional(object({<br>      storage_account_name = string<br>    }))<br><br>    os_disk = object({<br>      caching                   = optional(string, "ReadWrite")<br>      storage_account_type      = optional(string, "Standard_LRS")<br>      disk_size_gb              = optional(number)<br>      write_accelerator_enabled = optional(bool)<br>    })<br><br>    source_image_reference = object({<br>      publisher = string<br>      offer     = string<br>      sku       = string<br>      version   = string<br>    })<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_attachment_id"></a> [disk\_attachment\_id](#output\_disk\_attachment\_id) | The ID of the Virtual Machine Data Disk attachment |
| <a name="output_managed_disk_id"></a> [managed\_disk\_id](#output\_managed\_disk\_id) | The ID of the Managed Disk. |
| <a name="output_nic_id"></a> [nic\_id](#output\_nic\_id) | The network interface ID of the Windows Virtual Machine. |
| <a name="output_nic_location"></a> [nic\_location](#output\_nic\_location) | The network interface location of the Windows Virtual Machine. |
| <a name="output_nic_name"></a> [nic\_name](#output\_nic\_name) | The network interface name of the Windows Virtual Machine. |
| <a name="output_nic_resource_group_name"></a> [nic\_resource\_group\_name](#output\_nic\_resource\_group\_name) | The network interface resource group name of the Windows Virtual Machine. |
| <a name="output_vm_admin_password"></a> [vm\_admin\_password](#output\_vm\_admin\_password) | The windows admin password of the Windows Virtual Machine. |
| <a name="output_vm_admin_username"></a> [vm\_admin\_username](#output\_vm\_admin\_username) | The windows admin username of the Windows Virtual Machine. |
| <a name="output_vm_availability_set_id"></a> [vm\_availability\_set\_id](#output\_vm\_availability\_set\_id) | The availability set ID of the Windows Virtual Machine. |
| <a name="output_vm_capacity_reservation_group_id"></a> [vm\_capacity\_reservation\_group\_id](#output\_vm\_capacity\_reservation\_group\_id) | The capacity reservation group ID of the Windows Virtual Machine. |
| <a name="output_vm_computer_name"></a> [vm\_computer\_name](#output\_vm\_computer\_name) | The computer name of the Windows Virtual Machine. Name should not exceed 15 characters |
| <a name="output_vm_custom_data"></a> [vm\_custom\_data](#output\_vm\_custom\_data) | The custom data of the Windows Virtual Machine. |
| <a name="output_vm_dedicated_host_group_id"></a> [vm\_dedicated\_host\_group\_id](#output\_vm\_dedicated\_host\_group\_id) | The dedicated hostgroup ID of the Windows Virtual Machine. |
| <a name="output_vm_dedicated_host_id"></a> [vm\_dedicated\_host\_id](#output\_vm\_dedicated\_host\_id) | The dedicated host ID of the Windows Virtual Machine. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The ID of the Windows Virtual Machine. |
| <a name="output_vm_location"></a> [vm\_location](#output\_vm\_location) | The location of the Windows Virtual Machine. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the Windows Virtual Machine. |
| <a name="output_vm_network_interface_ids"></a> [vm\_network\_interface\_ids](#output\_vm\_network\_interface\_ids) | The network interface ID of the Windows Virtual Machine. |
| <a name="output_vm_os_disk"></a> [vm\_os\_disk](#output\_vm\_os\_disk) | The OS disk value of the Windows Virtual Machine. |
| <a name="output_vm_private_ip_address"></a> [vm\_private\_ip\_address](#output\_vm\_private\_ip\_address) | The private ip address of the Windows Virtual Machine. |
| <a name="output_vm_public_ip_address"></a> [vm\_public\_ip\_address](#output\_vm\_public\_ip\_address) | The public ip address of the Windows Virtual Machine. |
| <a name="output_vm_public_ip_addresses"></a> [vm\_public\_ip\_addresses](#output\_vm\_public\_ip\_addresses) | The public ip addresses of the Windows Virtual Machine. |
| <a name="output_vm_resource_group_name"></a> [vm\_resource\_group\_name](#output\_vm\_resource\_group\_name) | The resource group name of the Windows Virtual Machine. |
| <a name="output_vm_size"></a> [vm\_size](#output\_vm\_size) | The size/SKU of the Windows Virtual Machine. |
| <a name="output_vm_source_image_id"></a> [vm\_source\_image\_id](#output\_vm\_source\_image\_id) | The source image id of the Windows Virtual Machine. |
| <a name="output_vm_user_data"></a> [vm\_user\_data](#output\_vm\_user\_data) | The user data value of the Windows Virtual Machine. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->