# Create Storage Account
resource "azurerm_storage_account" "this" {
  for_each                          = var.storage_accounts != null ? var.storage_accounts : null
  name                              = each.value["name"]
  resource_group_name               = each.value["resource_group_name"]
  location                          = each.value["location"]
  account_kind                      = each.value["account_kind"]
  account_tier                      = each.value["account_tier"]
  account_replication_type          = each.value["account_replication_type"]
  access_tier                       = each.value["access_tier"]
  public_network_access_enabled     = each.value["public_network_access_enabled"]
  enable_https_traffic_only         = each.value["enable_https_traffic_only"]
  is_hns_enabled                    = each.value["is_hns_enabled"]
  allow_nested_items_to_be_public   = each.value["allow_nested_items_to_be_public"]
  nfsv3_enabled                     = each.value["nfsv3_enabled"]
  large_file_share_enabled          = each.value["large_file_share_enabled"]
  min_tls_version                   = each.value["min_tls_version"]
  cross_tenant_replication_enabled  = each.value["cross_tenant_replication_enabled"]
  shared_access_key_enabled         = each.value["shared_access_key_enabled"]
  default_to_oauth_authentication   = each.value["default_to_oauth_authentication"]
  queue_encryption_key_type         = each.value["queue_encryption_key_type"]
  table_encryption_key_type         = each.value["table_encryption_key_type"]
  infrastructure_encryption_enabled = each.value["infrastructure_encryption_enabled"]
  allowed_copy_scope                = each.value["allowed_copy_scope"]
  sftp_enabled                      = each.value["sftp_enabled"]

  dynamic "blob_properties" {
    for_each = each.value["blob_properties"] != null ? [1] : []
    content {
      versioning_enabled            = each.value["blob_properties"].versioning_enabled
      change_feed_enabled           = each.value["blob_properties"].change_feed_enabled
      change_feed_retention_in_days = each.value["blob_properties"].change_feed_retention_in_days
      default_service_version       = each.value["blob_properties"].default_service_version
      last_access_time_enabled      = each.value["blob_properties"].last_access_time_enabled
      dynamic "delete_retention_policy" {
        for_each = each.value["blob_properties"]["delete_retention_policy"] != null ? [1] : []
        content {
          days = each.value["blob_properties"]["delete_retention_policy"].days
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each = each.value["blob_properties"]["container_delete_retention_policy"] != null ? [1] : []
        content {
          days = each.value["blob_properties"]["container_delete_retention_policy"].days
        }
      }
      dynamic "restore_policy" {
        for_each = each.value["blob_properties"]["restore_policy"] != null ? [1] : []
        content {
          days = each.value["blob_properties"]["restore_policy"].days
        }
      }
      dynamic "cors_rule" {
        for_each = each.value["blob_properties"]["cors_rule"] != null ? [1] : []
        content {
          allowed_headers    = each.value["blob_properties"]["cors_rule"].allowed_headers
          allowed_methods    = each.value["blob_properties"]["cors_rule"].allowed_methods
          allowed_origins    = each.value["blob_properties"]["cors_rule"].allowed_origins
          exposed_headers    = each.value["blob_properties"]["cors_rule"].exposed_headers
          max_age_in_seconds = each.value["blob_properties"]["cors_rule"].max_age_in_seconds
        }
      }
    }
  }
  dynamic "queue_properties" {
    for_each = each.value["queue_properties"] != null && each.value["account_kind"] == "BlobStorage" ? [1] : []
    content {
      dynamic "minute_metrics" {
        for_each = each.value["queue_properties"]["minute_metrics"] != null ? [1] : []
        content {
          enabled               = each.value["queue_properties"]["minute_metrics"].enabled
          version               = each.value["queue_properties"]["minute_metrics"].version
          include_apis          = each.value["queue_properties"]["minute_metrics"].include_apis
          retention_policy_days = each.value["queue_properties"]["minute_metrics"].retention_policy_days
        }
      }
      dynamic "cors_rule" {
        for_each = each.value["queue_properties"]["cors_rule"] != null ? [1] : []
        content {
          allowed_headers    = each.value["queue_properties"]["cors_rule"].allowed_headers
          allowed_methods    = each.value["queue_properties"]["cors_rule"].allowed_methods
          allowed_origins    = each.value["queue_properties"]["cors_rule"].allowed_origins
          exposed_headers    = each.value["queue_properties"]["cors_rule"].exposed_headers
          max_age_in_seconds = each.value["queue_properties"]["cors_rule"].max_age_in_seconds
        }
      }
      dynamic "logging" {
        for_each = each.value["queue_properties"]["logging"] != null ? [1] : []
        content {
          delete                = each.value["queue_properties"]["logging"].delete
          read                  = each.value["queue_properties"]["logging"].read
          version               = each.value["queue_properties"]["logging"].version
          write                 = each.value["queue_properties"]["logging"].write
          retention_policy_days = each.value["queue_properties"]["logging"].retention_policy_days
        }
      }
      dynamic "hour_metrics" {
        for_each = each.value["queue_properties"]["hour_metrics"] != null ? [1] : []
        content {
          enabled               = each.value["queue_properties"]["hour_metrics"].enabled
          version               = each.value["queue_properties"]["hour_metrics"].version
          include_apis          = each.value["queue_properties"]["hour_metrics"].include_apis
          retention_policy_days = each.value["queue_properties"]["hour_metrics"].retention_policy_days
        }
      }
    }
  }
  dynamic "share_properties" {
    for_each = each.value["share_properties"] != null ? [1] : []
    content {
      dynamic "cors_rule" {
        for_each = each.value["share_properties"]["cors_rule"] != null ? [1] : []
        content {
          allowed_headers    = each.value["share_properties"]["cors_rule"].allowed_headers
          allowed_methods    = each.value["share_properties"]["cors_rule"].allowed_methods
          allowed_origins    = each.value["share_properties"]["cors_rule"].allowed_origins
          exposed_headers    = each.value["share_properties"]["cors_rule"].exposed_headers
          max_age_in_seconds = each.value["share_properties"]["cors_rule"].max_age_in_seconds
        }
      }
      retention_policy {
        days = each.value["share_properties"]["retention_policy"].days
      }
      dynamic "smb" {
        for_each = each.value["share_properties"]["smb"] != null ? [1] : []
        content {
          versions                        = each.value["share_properties"]["smb"].versions
          authentication_types            = each.value["share_properties"]["smb"].authentication_types
          kerberos_ticket_encryption_type = each.value["share_properties"]["smb"].kerberos_ticket_encryption_type
          channel_encryption_type         = each.value["share_properties"]["smb"].channel_encryption_type
          multichannel_enabled            = each.value["share_properties"]["smb"].multichannel_enabled
        }
      }
    }
  }
  dynamic "static_website" {
    for_each = each.value["static_website"] != null ? [1] : []
    content {
      index_document     = each.value["static_website"].index_document
      error_404_document = each.value["static_website"].error_404_document
    }
  }
  dynamic "custom_domain" {
    for_each = each.value["custom_domain"] != null ? [1] : []
    content {
      name          = each.value["custom_domain"].name
      use_subdomain = each.value["custom_domain"].use_subdomain
    }
  }
  dynamic "immutability_policy" {
    for_each = each.value["immutability_policy"] != null ? [1] : []
    content {
      allow_protected_append_writes = each.value["immutability_policy"].allow_protected_append_writes
      state                         = each.value["immutability_policy"].state
      period_since_creation_in_days = each.value["immutability_policy"].period_since_creation_in_days
    }
  }
  network_rules {
    default_action             = each.value["network_rules"].default_action
    bypass                     = each.value["network_rules"].bypass
    ip_rules                   = concat(each.value["network_rules"].ip_rules, each.value["network_rules"].custom_ip_rules)
    virtual_network_subnet_ids = each.value["network_rules"].virtual_network_subnet_ids
    dynamic "private_link_access" {
      for_each = { for v in each.value["network_rules"]["private_link_access"] : v.endpoint_resource_id => v if v.endpoint_resource_id != null }
      content {
        endpoint_resource_id = private_link_access.value.endpoint_resource_id
        endpoint_tenant_id   = var.azurerm_client_config.tenant_id
      }
    }
  }
  dynamic "identity" {
    for_each = each.value["identity"] != null ? [1] : []
    content {
      type         = each.value["identity"].type
      identity_ids = each.value["identity"].type == "UserAssigned" ? var.user_assigned_identity_ids : null
    }
  }
  dynamic "routing" {
    for_each = each.value["routing"] != null ? [1] : []
    content {
      choice                      = each.value["routing"].choice
      publish_microsoft_endpoints = each.value["routing"].publish_microsoft_endpoints
      publish_internet_endpoints  = each.value["routing"].publish_internet_endpoints
    }
  }
  tags = var.tags
}

# Create Storage Shares
resource "azurerm_storage_share" "this" {
  for_each             = var.storage_shares == null ? {} : var.storage_shares
  name                 = each.value["name"]
  storage_account_name = each.value["storage_account_name"]
  quota                = each.value["quota"]
  access_tier          = each.value["access_tier"]
  enabled_protocol     = each.value["enabled_protocol"]
  acl {
    id = each.value["acl"].id
    access_policy {
      permissions = each.value["acl"]["access_policy"].permissions
      start       = each.value["acl"]["access_policy"].start
      expiry      = each.value["acl"]["access_policy"].expiry
    }
  }
  depends_on = [azurerm_storage_account.this]
}

# Create Datalake Filesystem
resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  for_each           = var.storage_data_lake_gen2_filesystem == null ? {} : var.storage_data_lake_gen2_filesystem
  name               = each.value["name"]
  storage_account_id = "/subscriptions/${var.azurerm_client_config.subscription_id}/resourceGroups/${each.value["resource_group_name"]}/providers/Microsoft.Storage/storageAccounts/${each.value["storage_account_name"]}"
  properties         = each.value["properties"]
  owner              = var.data_lake_owner_id
  group              = var.data_lake_group_id

  dynamic "ace" {
    for_each = each.value["ace"] != null ? [1] : []
    content {
      scope       = each.value["ace"].scope
      type        = each.value["ace"].type
      permissions = each.value["ace"].permissions
      id          = var.data_lake_id
    }
  }
  depends_on = [azurerm_storage_account.this]
}

# Create Storage Container
resource "azurerm_storage_container" "this" {
  for_each              = var.storage_containers == null ? {} : var.storage_containers
  name                  = each.value["name"]
  storage_account_name  = each.value["storage_account_name"]
  container_access_type = each.value["container_access_type"]
  depends_on            = [azurerm_storage_account.this, azurerm_storage_data_lake_gen2_filesystem.this]
}
