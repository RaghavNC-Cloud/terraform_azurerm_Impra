# Generates random password
resource "random_password" "this" {
  for_each         = var.windows_vms
  length           = 16
  special          = true
  upper            = true
  numeric          = true
  override_special = "-!#$%&()*/:;?@[]^_{|}~+<=>"
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
}

# Create Network Interface for VM
resource "azurerm_network_interface" "this" {
  for_each                      = var.network_interface != null ? var.network_interface : {}
  name                          = each.value["name"]
  location                      = each.value["location"]
  resource_group_name           = each.value["resource_group_name"]
  enable_ip_forwarding          = each.value["enable_ip_forwarding"]
  enable_accelerated_networking = each.value["enable_accelerated_networking"]
  internal_dns_name_label       = trimsuffix(each.value["name"], "-nic")
  dns_servers                   = each.value["dns_servers"]
  tags                          = var.tags
  dynamic "ip_configuration" {
    for_each = each.value["ip_configuration"]
    content {
      name                                               = ip_configuration.value.name
      subnet_id                                          = ip_configuration.value.private_ip_address_version == "IPv4" ? "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${ip_configuration.value.vnet_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${ip_configuration.value.virtual_network_name}/subnets/${ip_configuration.value.subnet_name}" : null
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.enable_lb_frontend == true ? "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${ip_configuration.value.lb_resource_group_name}/providers/Microsoft.Network/loadBalancers/${ip_configuration.value.lb_name}/frontendIPConfigurations/${ip_configuration.value.fe_ip_config_name}" : null
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      private_ip_address                                 = ip_configuration.value.private_ip_address_allocation == "Static" ? ip_configuration.value.private_ip_address : null
      public_ip_address_id                               = ip_configuration.value.enable_public_ip_address == true ? "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${ip_configuration.value.public_ip_resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${ip_configuration.value.public_ip_name}" : null
      primary                                            = ip_configuration.value.primary
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

#Creating virtual machine
resource "azurerm_windows_virtual_machine" "this" {
  for_each                   = var.windows_vms != null ? var.windows_vms : null
  name                       = each.value["name"]
  computer_name              = each.value["computer_name"]
  location                   = each.value["location"]
  resource_group_name        = each.value["resource_group_name"]
  network_interface_ids      = each.value["network_interface_ids"]
  size                       = each.value["size"]
  admin_username             = each.value["admin_username"]
  admin_password             = random_password.this[each.key].result
  zone                       = each.value["zone"]
  provision_vm_agent         = each.value["provision_vm_agent"]
  allow_extension_operations = each.value["allow_extension_operations"]
  custom_data                = each.value["custom_data"]
  user_data                  = each.value["user_data"]
  patch_mode                 = each.value["patch_mode"]
  patch_assessment_mode      = each.value["patch_assessment_mode"]
  eviction_policy            = each.value["eviction_policy"]
  extensions_time_budget     = each.value["extensions_time_budget"]
  hotpatching_enabled        = each.value["hotpatching_enabled"]
  license_type               = each.value["license_type"]
  max_bid_price              = each.value["max_bid_price"]
  priority                   = each.value["priority"]
  secure_boot_enabled        = each.value["secure_boot_enabled"]
  timezone                   = each.value["timezone"]
  tags                       = merge(var.tags, each.value["extra_tags"])

  dynamic "identity" {
    for_each = each.value["identity"] != null ? [1] : []
    content {
      type         = each.value["identity"].type
      identity_ids = each.value["identity"].type == "UserAssigned" ? var.user_assigned_identity_ids : null
    }
  }

  dynamic "boot_diagnostics" {
    for_each = each.value["boot_diagnostics"] != null ? [1] : []
    content {
      storage_account_uri = "https://${each.value["storage_account_name"]}.blob.core.windows.net/"
    }
  }

  os_disk {
    name                      = "${each.value["name"]}-osdisk"
    caching                   = each.value["os_disk"].caching
    storage_account_type      = each.value["os_disk"].storage_account_type
    disk_size_gb              = each.value["os_disk"].disk_size_gb
    write_accelerator_enabled = each.value["os_disk"].write_accelerator_enabled
  }

  source_image_reference {
    publisher = each.value["source_image_reference"].publisher
    offer     = each.value["source_image_reference"].offer
    sku       = each.value["source_image_reference"].sku
    version   = each.value["source_image_reference"].version
  }

  dynamic "plan" {
    for_each = each.value["marketplace_image"] == true ? [1] : []
    content {
      name      = each.value["source_image_reference"].sku
      product   = each.value["source_image_reference"].offer
      publisher = each.value["source_image_reference"].publisher
    }
  }

  lifecycle {
    ignore_changes = [admin_password]
  }

  depends_on = [azurerm_network_interface.this, random_password.this]
}

# Create additional managed disks for VMs
resource "azurerm_managed_disk" "this" {
  for_each             = var.managed_disk_config != null ? var.managed_disk_config : {}
  name                 = each.value["name"]
  resource_group_name  = each.value["resource_group_name"]
  location             = each.value["location"]
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  zone                 = each.value.zone
  disk_size_gb         = each.value.disk_size_gb
  source_resource_id   = contains(["Copy", "Restore"], each.value.create_option) ? var.source_resource_id : null
  tags                 = var.tags
}

# Attach managed disks to VMs
resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each           = var.disk_attachment != null ? var.disk_attachment : {}
  virtual_machine_id = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.vm_resource_group_name}/providers/Microsoft.Compute/virtualMachines/${each.value.vm_name}"
  managed_disk_id    = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.disk_resource_group_name}/providers/Microsoft.Compute/disks/${each.value.disk_name}"
  lun                = each.value.lun
  caching            = each.value.caching
  depends_on         = [azurerm_managed_disk.this, azurerm_windows_virtual_machine.this]
}

# Join machine to ic.ac.uk domain
resource "azurerm_virtual_machine_extension" "domjoin" {
  for_each             = var.windows_vms
  name                 = "domainjoin"
  virtual_machine_id   = azurerm_windows_virtual_machine.this[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
  settings = <<SETTINGS
{
"Name": "${var.tf_ad_domain_variables["domain_name"]}",
"OUPath": "${var.tf_ad_domain_variables["${each.value.ou_path}"]}",
"User": "${var.tf_ad_domain_variables["domain_name"]}\\${var.tf_ad_domain_variables["domain_account_name"]}",
"Restart": "true",
"Options": "3"
}
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${var.domain_account_password}"
}
PROTECTED_SETTINGS

  depends_on = [azurerm_virtual_machine_extension.vm_extension]
}

# Pre Install Script
resource "azurerm_virtual_machine_extension" "vm_extension" {
  for_each                   = var.windows_vms
  name                       = "windows-pre-install"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[each.key].id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  tags                       = var.tags
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
 {
     "fileUris": ["https://ictcloudteamfiles.blob.core.windows.net/powershell-scripts/Pre-install.ps1"],
     "commandToExecute": "powershell -command \"./Pre-install.ps1; exit 0; \""
 }
 SETTINGS
  depends_on                 = [azurerm_windows_virtual_machine.this]
}
