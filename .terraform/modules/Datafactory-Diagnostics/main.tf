# Get diagnostic settings categories for resource
data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = var.resource_id
}

# Create diagnostics settings for resource to send logs to eventhub or law or storage account
resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each                       = var.diag_config
  name                           = each.value["name"]
  target_resource_id             = each.value["target_resource_id"]
  eventhub_name                  = each.value["eventhub_name"]
  eventhub_authorization_rule_id = local.eventhub_authorization_rule_id
  log_analytics_workspace_id     = local.log_analytics_workspace_id
  log_analytics_destination_type = local.log_analytics_destination_type
  storage_account_id             = local.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.log_category_types
    content {
      category = log.value
      enabled  = contains(var.log_category, log.value)

      retention_policy {
        enabled = contains(var.log_category, log.value)
        days    = contains(var.log_category, log.value) == true ? var.log_rp_days : 0
      }
    }
  }

  # Metrics are enabled by default
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this.metrics
    content {
      category = metric.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.metric_rp_days
      }
    }
  }
}
