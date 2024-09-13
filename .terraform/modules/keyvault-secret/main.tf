# Create Keyvault secret
resource "azurerm_key_vault_secret" "this" {
  for_each        = var.keyvault_secret_config
  name            = each.value["name"]
  value           = each.value["secret_value"]
  content_type    = each.value["content_type"]
  not_before_date = each.value["not_before_date"]
  expiration_date = each.value["expiration_date"]
  key_vault_id    = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.kv_resource_group_name}/providers/Microsoft.KeyVault/vaults/${each.value.kv_name}"
  tags            = var.tags
}
