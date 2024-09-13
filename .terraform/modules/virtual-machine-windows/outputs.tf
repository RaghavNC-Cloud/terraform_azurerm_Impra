output "vm_id" {
  description = "The ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.id }
}

output "vm_name" {
  description = "The name of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.name }
}

output "vm_location" {
  description = "The location of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.location }
}

output "vm_size" {
  description = "The size/SKU of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.size }
}

output "vm_computer_name" {
  description = "The computer name of the Windows Virtual Machine. Name should not exceed 15 characters"
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.computer_name }
}

output "vm_resource_group_name" {
  description = "The resource group name of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.resource_group_name }
}

output "vm_admin_password" {
  description = "The windows admin password of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.admin_password }
  sensitive   = true
}

output "vm_admin_username" {
  description = "The windows admin username of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.admin_username }
}

output "vm_availability_set_id" {
  description = "The availability set ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.availability_set_id }
}

output "vm_capacity_reservation_group_id" {
  description = "The capacity reservation group ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.capacity_reservation_group_id }
}

output "vm_custom_data" {
  description = "The custom data of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.custom_data }
}

output "vm_dedicated_host_group_id" {
  description = "The dedicated hostgroup ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.dedicated_host_group_id }
}

output "vm_dedicated_host_id" {
  description = "The dedicated host ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.dedicated_host_id }
}

output "vm_network_interface_ids" {
  description = "The network interface ID of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.network_interface_ids }
}

output "vm_os_disk" {
  description = "The OS disk value of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.os_disk }
}

output "vm_private_ip_address" {
  description = "The private ip address of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.private_ip_address }
}

output "vm_public_ip_address" {
  description = "The public ip address of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.public_ip_address }
}

output "vm_public_ip_addresses" {
  description = "The public ip addresses of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.public_ip_addresses }
}

output "vm_source_image_id" {
  description = "The source image id of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.source_image_id }
}

output "vm_user_data" {
  description = "The user data value of the Windows Virtual Machine."
  value       = { for v in azurerm_windows_virtual_machine.this : v.name => v.user_data }
}

output "nic_id" {
  description = "The network interface ID of the Windows Virtual Machine."
  value       = { for v in azurerm_network_interface.this : v.name => v.id }
}

output "nic_name" {
  description = "The network interface name of the Windows Virtual Machine."
  value       = { for v in azurerm_network_interface.this : v.name => v.name }
}

output "nic_location" {
  description = "The network interface location of the Windows Virtual Machine."
  value       = { for v in azurerm_network_interface.this : v.name => v.location }
}

output "nic_resource_group_name" {
  description = "The network interface resource group name of the Windows Virtual Machine."
  value       = { for v in azurerm_network_interface.this : v.name => v.resource_group_name }
}

output "managed_disk_id" {
  description = "The ID of the Managed Disk."
  value       = { for v in azurerm_managed_disk.this : v.name => v.id }
}

output "disk_attachment_id" {
  description = "The ID of the Virtual Machine Data Disk attachment"
  value       = { for v in azurerm_virtual_machine_data_disk_attachment.this : v.lun => v.id }
}
