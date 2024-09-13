variable "mssql_servers" {
  description = <<-EOF
    Parameters used to create `Azure SQL Server`

    `name` = (`Required` The name of the SQL Server.)

    `resource_group_name` = (`Required` The name of the resource group in which to create the SQL Server.)

    `location` = (`Optional` The Azure region where the SQL Server will be created., Defaults to `uksouth`)

    `version` = (`Required` The version of the SQL Server.)

    `connection_policy` = (`Optional` The connection policy for the SQL Server.)

    `outbound_network_restriction_enabled` = (`Optional` Specifies whether outbound network access is restricted for the SQL Server.)

    `public_network_access_enabled` = (`Optional` Specifies whether public network access is allowed for the SQL Server.)

    `minimum_tls_version` = (`Optional` The minimum TLS version supported by the SQL Server.)

    `administrator_login` = (`Required` Specifies the name of the SQL administrator.)

    `identity` = (`Optional` The managed identity for the SQL Server.)

    `type` = (`Required` The type of managed identity.)

    `identity_ids` = (`Optional` The list of identity IDs associated with the SQL Server.)

    `azuread_administrator` = (`Required` The Azure AD administrator settings for the SQL Server.)

    `login_username` = (`Required` The login username for the Azure AD administrator.)

    `azuread_authentication_only` = (`Optional` Specifies whether Azure AD authentication is the only authentication method allowed.)
    EOF
  type = map(object({
    name                                 = string
    resource_group_name                  = string
    location                             = optional(string, "uksouth")
    version                              = string
    connection_policy                    = optional(string)
    outbound_network_restriction_enabled = optional(bool)
    public_network_access_enabled        = optional(bool)
    minimum_tls_version                  = optional(string, "1.2")
    administrator_login                  = optional(string)

    identity = optional(object({
      type = string
    }))

    azuread_administrator = object({
      login_username              = string
      object_id                   = string
      azuread_authentication_only = optional(bool, true)
    })
  }))
  default = null
}

variable "user_assigned_identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to MSSQL server."
  type        = list(string)
  default     = null
}

variable "mssql_databases" {
  description = <<-EOF

  Parameters used to create `Azure SQL Database`

  `name` = (`Required` The name of the SQL Database.)

  `sql_server_resource_group_name` = (`Required` The name of the resource group containing the SQL Server.)

  `sql_server_name` = (`Required` The name of the SQL Server.)

  `collation` = (`Optional` The collation of the SQL Database. Defaults to `SQL_Latin1_General_CP1_CI_AS`)

  `max_size_gb` = (`Optional` The maximum size of the SQL Database in gigabytes.)

  `sku_name` = (`Optional` The SKU (pricing tier) of the SQL Database.)

  `storage_account_type` = (`Optional` The storage account type of the SQL Database. Defaults to "Local")

  `auto_pause_delay_in_minutes` = (`Optional` Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases.)

  `geo_backup_enabled` = (`Optional` A boolean that specifies if the Geo Backup Policy is enabled. Defaults to `true`)

  `maintenance_configuration_name` = (`Optional` The name of the Public Maintenance Configuration window to apply to the database.)

  `ledger_enabled` = (`Optional` A boolean that specifies if this is a ledger database. Defaults to `false`)

  `license_type` = (`Optional` Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice.)

  `min_capacity` = (`Optional` Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases.)

  `transparent_data_encryption_enabled` = (`Optional` If set to true, Transparent Data Encryption will be enabled on the database. Defaults to `true`)

  `zone_redundant` = (`Optional` Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.)

  `create_mode` = (`Optional` The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. Mutually exclusive with import. Changing this forces a new resource to be created.)

  `restore_point_in_time` = (`Optional` Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases.)

  `read_replica_count` = (`Optional` The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases.)

  `read_scale` = (`Optional` If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.)

  `sample_name` = (`Optional` Specifies the name of the sample schema to apply when creating this database.)

  `short_term_retention_policy` = (`Optional` The short-term retention policy for the SQL Database.)

  `retention_days` = (`Optional` The number of days to retain backups. Defaults to `30`)

  `backup_interval_in_hours` = (`Optional` The backup interval in hours. Defaults to `24`)

  `long_term_retention_policy` = (`Optional` The long-term retention policy for the SQL Database.)

  `weekly_retention` = (`Optional` The number of weeks to retain backups.)

  `monthly_retention` = (`Optional` The number of months to retain backups.)

  `yearly_retention` = (`Optional` The number of years to retain backups.)

  `week_of_year` = (`Optional` The week of the year for backup retention.)

  `threat_detection_policy`  = (`Optional` Threat detection policy configuration. The threat_detection_policy block supports fields documented below.)

  `state` = (`Optional` The State of the Policy. Possible values are Enabled, Disabled or New.)

  `disabled_alerts` = (`Optional` Specifies a list of alerts which should be disabled. Possible values include Access_Anomaly, Sql_Injection and Sql_Injection_Vulnerability.)

  `email_account_admins` = (`Optional` Should the account administrators be emailed when this alert is triggered? Possible values are Disabled and Enabled.)

  `email_addresses` = (`Optional` A list of email addresses which alerts should be sent to.)

  `retention_days` = (`Optional` Specifies the number of days to keep in the Threat Detection audit logs. Defaults to `30`)

  `import` = (`Optional` A Database Import block as documented below. Mutually exclusive with create_mode.)

  `storage_key_type` = (`Required` Specifies the type of access key for the storage account. Valid values are StorageAccessKey or SharedAccessKey.)

  `authentication_type` = (`Required` Specifies the type of authentication used to access the server. Valid values are SQL or ADPassword.)
  EOF
  type = map(object({
    name                                = string
    sql_server_resource_group_name      = string
    sql_server_name                     = string
    collation                           = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    max_size_gb                         = optional(number)
    sku_name                            = optional(string)
    storage_account_type                = optional(string, "Local")
    auto_pause_delay_in_minutes         = optional(number)
    geo_backup_enabled                  = optional(bool)
    maintenance_configuration_name      = optional(string)
    ledger_enabled                      = optional(bool)
    license_type                        = optional(string)
    min_capacity                        = optional(number)
    transparent_data_encryption_enabled = optional(bool)
    zone_redundant                      = optional(string)
    create_mode                         = optional(string)
    restore_point_in_time               = optional(string)
    read_replica_count                  = optional(number)
    read_scale                          = optional(bool)
    sample_name                         = optional(string)

    short_term_retention_policy = optional(object({
      retention_days           = optional(number, 30)
      backup_interval_in_hours = optional(string, 24)
    }))

    long_term_retention_policy = optional(object({
      weekly_retention  = optional(number)
      monthly_retention = optional(number)
      yearly_retention  = optional(number)
      week_of_year      = optional(number)
    }))

    threat_detection_policy = optional(object({
      state                = optional(string)
      disabled_alerts      = optional(string)
      email_account_admins = optional(string)
      email_addresses      = optional(list(string))
      retention_days       = optional(number, 30)
      keyvault_name        = optional(string)
      secret_name          = optional(string)
      storage_account_name = optional(string)
    }))
  }))
  default = null
}

variable "sql_fw_rule" {
  description = <<-EOF

    `name` - (`Required` The name of the firewall rule. Changing this forces a new resource to be created.)

    `sql_server_resource_group_name` = (`Required` The name of the resource group containing the SQL Server.)

    `sql_server_name` = (`Required` The name of the SQL Server.)

    `start_ip_address` - (`Required` The starting IP address to allow through the firewall for this rule.)

    `end_ip_address` - (`Required` The ending IP address to allow through the firewall for this rule.)

  EOF
  type        = list(map(string))
  /*
    name                           = string
    sql_server_resource_group_name = string
    sql_server_name                = string
    start_ip_address               = string
    end_ip_address                 = string
  */
  default = []
}

variable "enable_azure_services" {
  description = "Allow access to Azure services"
  type        = bool
  default     = true
  validation {
    condition     = contains([true, false], var.enable_azure_services)
    error_message = "valid values are true or false"
  }
}

variable "server_id" {
  description = "Azure MSSQL Server ID"
  type        = string
  default     = null
}

variable "storage_account_access_key" {
  description = "Specifies the identifier key of the Threat Detection audit storage account. Required if state is Enabled."
  type        = string
  default     = null
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
