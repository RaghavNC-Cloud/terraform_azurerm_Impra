# Get the configuration of the AzureRM provider
data "azurerm_client_config" "current" {}

# Create Keyvault Access policy
resource "azurerm_key_vault_access_policy" "this" {
  for_each                = var.kv_access_policy
  key_vault_id            = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value["keyvault_resource_group_name"]}/providers/Microsoft.KeyVault/vaults/${each.value["keyvault_name"]}"
  tenant_id               = var.azurerm_client_config.tenant_id
  object_id               = each.value["object_id"]
  application_id          = each.value["application_id"]
  key_permissions         = each.value["key_permissions"]
  secret_permissions      = each.value["secret_permissions"]
  certificate_permissions = each.value["certificate_permissions"]
  storage_permissions     = each.value["storage_permissions"]
}
