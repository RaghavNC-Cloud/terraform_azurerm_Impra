# Create Datafactory
resource "azurerm_data_factory" "this" {
  for_each                        = var.adf_config != null ? var.adf_config : null
  name                            = each.value["name"]
  location                        = each.value["location"]
  resource_group_name             = each.value["resource_group_name"]
  managed_virtual_network_enabled = each.value["managed_virtual_network_enabled"]
  public_network_enabled          = each.value["public_network_enabled"]
  tags                            = var.tags

  identity {
    type = "SystemAssigned"
  }

  dynamic "github_configuration" {
    for_each = each.value["github_configuration"] != null ? [1] : []
    content {
      account_name    = each.value["github_configuration"].account_name
      branch_name     = each.value["github_configuration"].branch_name
      git_url         = each.value["github_configuration"].git_url
      repository_name = each.value["github_configuration"].repository_name
      root_folder     = each.value["github_configuration"].root_folder
    }
  }

  dynamic "vsts_configuration" {
    for_each = each.value["vsts_configuration"] != null ? [1] : []

    content {
      account_name    = each.value["vsts_configuration"].account_name
      branch_name     = each.value["vsts_configuration"].branch_name
      project_name    = each.value["vsts_configuration"].project_name
      repository_name = each.value["vsts_configuration"].repository_name
      root_folder     = each.value["vsts_configuration"].root_folder
      tenant_id       = var.azurerm_client_config.tenant_id
    }
  }
  lifecycle {
    ignore_changes = [vsts_configuration, github_configuration, global_parameter]
  }
}

# Create datafactory private endpoints
resource "azurerm_data_factory_managed_private_endpoint" "this" {
  for_each           = var.adf_pe_config != null ? var.adf_pe_config : null
  name               = each.value["name"]
  data_factory_id    = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.data_factory_resource_group}/providers/Microsoft.DataFactory/factories/${each.value.data_factory_name}"
  target_resource_id = each.value["target_resource_id"]
  subresource_name   = each.value["subresource_name"]
  fqdns              = each.value["fqdns"]
  depends_on         = [azurerm_data_factory.this]
}

# Create datafactory Azure integration runtime
resource "azurerm_data_factory_integration_runtime_azure" "this" {
  for_each                = var.integration_runtime_configuration_azure != null ? var.integration_runtime_configuration_azure : {}
  data_factory_id         = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.data_factory_resource_group}/providers/Microsoft.DataFactory/factories/${each.value.data_factory_name}"
  name                    = each.value["name"]
  location                = each.value["location"]
  description             = each.value["description"]
  cleanup_enabled         = each.value["cleanup_enabled"]
  compute_type            = each.value["compute_type"]
  core_count              = each.value["core_count"]
  time_to_live_min        = each.value["time_to_live_min"]
  virtual_network_enabled = each.value["virtual_network_enabled"]
  depends_on              = [azurerm_data_factory.this]
}

# Create datafactory self hosted integration runtime
resource "azurerm_data_factory_integration_runtime_self_hosted" "this" {
  for_each        = { for v in coalesce(var.integration_runtime_configuration_azure_self_hosted, []) : v.name => v }
  data_factory_id = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.data_factory_resource_group}/providers/Microsoft.DataFactory/factories/${each.value.data_factory_name}"
  name            = each.value["name"]
  description     = each.value["description"]
  depends_on      = [azurerm_data_factory.this]
}

# Create datafactory SSIS integration runtime
resource "azurerm_data_factory_integration_runtime_azure_ssis" "this" {
  for_each                         = var.integration_runtime_configuration_azure_ssis != null ? var.integration_runtime_configuration_azure_ssis : {}
  data_factory_id                  = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value.data_factory_resource_group}/providers/Microsoft.DataFactory/factories/${each.value.data_factory_name}"
  name                             = each.value["name"]
  location                         = each.value["location"]
  description                      = each.value["description"]
  node_size                        = each.value["node_size"]
  number_of_nodes                  = each.value["number_of_nodes"]
  max_parallel_executions_per_node = each.value["number_of_nodes"]
  edition                          = each.value["edition"]
  license_type                     = each.value["license_type"]
  depends_on                       = [azurerm_data_factory.this]
}
