# Create Azure Keyvault
resource "azurerm_key_vault" "this" {
  for_each                        = var.key_vaults == null ? {} : var.key_vaults
  name                            = each.value["name"]
  location                        = each.value.location
  resource_group_name             = each.value["resource_group_name"]
  sku_name                        = each.value["sku_name"]
  enabled_for_disk_encryption     = each.value["enabled_for_disk_encryption"]
  tenant_id                       = var.azurerm_client_config.tenant_id
  soft_delete_retention_days      = each.value["soft_delete_retention_days"]
  purge_protection_enabled        = each.value["purge_protection_enabled"]
  enable_rbac_authorization       = each.value["enable_rbac_authorization"]
  enabled_for_deployment          = each.value["enabled_for_deployment"]
  enabled_for_template_deployment = each.value["enabled_for_template_deployment"]
  tags                            = var.tags

  network_acls {
    bypass                     = each.value["network_acls"].bypass
    default_action             = each.value["network_acls"].default_action
    ip_rules                   = concat(each.value["network_acls"].ip_rules, each.value["network_acls"].custom_ip_rules)
    virtual_network_subnet_ids = each.value["network_acls"].virtual_network_subnet_ids
  }
}

