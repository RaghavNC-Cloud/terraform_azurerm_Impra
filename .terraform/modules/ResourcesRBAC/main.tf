resource "azurerm_role_assignment" "this" {
  for_each                         = var.rbac_config
  role_definition_name             = each.value.role_definition_name
  scope                            = each.value.scope
  principal_id                     = each.value.object_id
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check
}
