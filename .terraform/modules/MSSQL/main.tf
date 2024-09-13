# Create Random password for MSSQL admin account
resource "random_password" "this" {
  for_each         = var.mssql_servers
  length           = 16
  special          = true
  upper            = true
  numeric          = true
  min_lower        = 2
  min_special      = 2
  override_special = "!$#%"
  min_numeric      = 2
  min_upper        = 2
}

# Create MSSQL Server
resource "azurerm_mssql_server" "this" {
  for_each                             = var.mssql_servers != null ? var.mssql_servers : null
  name                                 = each.value["name"]
  resource_group_name                  = each.value["resource_group_name"]
  location                             = each.value["location"]
  version                              = each.value["version"]
  connection_policy                    = each.value["connection_policy"]
  outbound_network_restriction_enabled = each.value["outbound_network_restriction_enabled"]
  public_network_access_enabled        = each.value["public_network_access_enabled"]
  minimum_tls_version                  = each.value["minimum_tls_version"]
  administrator_login                  = each.value["administrator_login"]
  administrator_login_password         = random_password.this[each.key].result

  dynamic "identity" {
    for_each = each.value["identity"] != null ? [1] : []
    content {
      type         = each.value["identity"].type
      identity_ids = each.value["identity"].type == "UserAssigned" ? var.user_assigned_identity_ids : null
    }
  }

  azuread_administrator {
    login_username              = each.value["azuread_administrator"].login_username
    object_id                   = each.value["azuread_administrator"].object_id
    tenant_id                   = var.azurerm_client_config.tenant_id
    azuread_authentication_only = each.value["azuread_administrator"].azuread_authentication_only
  }

  lifecycle {
    ignore_changes = [administrator_login_password]
  }

  tags = var.tags
}

# Create MSSQL Database
resource "azurerm_mssql_database" "this" {
  for_each                            = var.mssql_databases == null ? {} : var.mssql_databases
  name                                = each.value["name"]
  server_id                           = var.server_id == null ? "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value["sql_server_resource_group_name"]}/providers/Microsoft.Sql/servers/${each.value["sql_server_name"]}" : var.server_id
  collation                           = each.value["collation"]
  max_size_gb                         = each.value["max_size_gb"]
  sku_name                            = each.value["sku_name"]
  storage_account_type                = each.value["storage_account_type"]
  auto_pause_delay_in_minutes         = each.value["auto_pause_delay_in_minutes"]
  geo_backup_enabled                  = each.value["geo_backup_enabled"]
  maintenance_configuration_name      = each.value["maintenance_configuration_name"]
  ledger_enabled                      = each.value["ledger_enabled"]
  license_type                        = each.value["license_type"]
  min_capacity                        = each.value["min_capacity"]
  transparent_data_encryption_enabled = each.value["transparent_data_encryption_enabled"]
  zone_redundant                      = each.value["zone_redundant"]
  create_mode                         = each.value["create_mode"]
  restore_point_in_time               = each.value["restore_point_in_time"]
  read_replica_count                  = each.value["read_replica_count"]
  read_scale                          = each.value["read_scale"]
  sample_name                         = each.value["sample_name"]

  dynamic "short_term_retention_policy" {
    for_each = each.value["short_term_retention_policy"] != null ? [1] : []
    content {
      retention_days           = each.value["short_term_retention_policy"].retention_days
      backup_interval_in_hours = each.value["short_term_retention_policy"].backup_interval_in_hours
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = each.value["long_term_retention_policy"] != null ? [1] : []
    content {
      weekly_retention  = each.value["long_term_retention_policy"].weekly_retention
      monthly_retention = each.value["long_term_retention_policy"].monthly_retention
      yearly_retention  = each.value["long_term_retention_policy"].yearly_retention
      week_of_year      = each.value["long_term_retention_policy"].week_of_year
    }
  }

  dynamic "threat_detection_policy" {
    for_each = each.value["threat_detection_policy"] != null ? [1] : []
    content {
      state                      = each.value["threat_detection_policy"].state
      disabled_alerts            = each.value["threat_detection_policy"].disabled_alerts
      email_account_admins       = each.value["threat_detection_policy"].email_account_admins
      email_addresses            = each.value["threat_detection_policy"].email_addresses
      retention_days             = each.value["threat_detection_policy"].retention_days
      storage_account_access_key = var.storage_account_access_key == null ? "@Microsoft.KeyVault(VaultName=${each.value["threat_detection_policy"].keyvault_name};SecretName=${each.value["threat_detection_policy"].secret_name})" : var.storage_account_access_key
      storage_endpoint           = "https://${each.value["storage_account_name"]}.blob.core.windows.net/"
    }
  }

  depends_on = [
    azurerm_mssql_server.this
  ]
}

# Allow Azure resources to access Azure MSSQL
resource "azurerm_mssql_firewall_rule" "azure_services" {
  for_each         = var.enable_azure_services == true ? azurerm_mssql_server.this : null
  name             = "Azure Services"
  server_id        = each.value.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [
    azurerm_mssql_server.this
  ]
}

# Create custom MSSQL FW rule
resource "azurerm_mssql_firewall_rule" "this" {
  for_each         = { for v in var.sql_fw_rule : "${v.name}-${v.sql_server_name}" => v if var.sql_fw_rule != null }
  name             = each.value["name"]
  server_id        = var.server_id == null ? "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value["sql_server_resource_group_name"]}/providers/Microsoft.Sql/servers/${each.value["sql_server_name"]}" : var.server_id
  start_ip_address = each.value["start_ip_address"]
  end_ip_address   = each.value["end_ip_address"]

  depends_on = [
    azurerm_mssql_server.this
  ]
}
