variable "storage_accounts" {
  description = <<-EOF
  Parameters used to create `Azure Storage Account`

  `name` = (`Required` The name of the storage account.)

  `resource_group_name` = (`Required` The name of the resource group in which to create the storage account.)

  `location` = (`Optional` The Azure region where the storage account will be created. Defaults to `uksouth`)

  `account_kind` = (`Optional` The kind of storage account. Defaults to `StorageV2`)

  `account_tier` = (`Required` The tier of the storage account.)

  `account_replication_type` = (`Required` The replication type of the storage account.)

  `access_tier` = (`Optional` The access tier of the storage account. Defaults to `Hot`)

  `public_network_access_enabled` = (`Optional` Specifies whether public network access is allowed for the storage account. Defaults to `true`)

  `enable_https_traffic_only` = (`Optional` Specifies whether HTTPS traffic is required for the storage account. Defaults to `true`)

  `is_hns_enabled` = (`Optional` Specifies whether Hierarchical Namespace (HNS) is enabled for the storage account.)

  `allow_nested_items_to_be_public` = (`Optional` Specifies whether nested items can be set as public in the storage account. Defaults to `false`)

  `nfsv3_enabled` = (`Optional` Specifies whether NFSv3 protocol is enabled for the storage account. Defaults to `false`)

  `large_file_share_enabled` = (`Optional` Specifies whether large file shares are enabled for the storage account. Defaults to `true`)

  `min_tls_version` = (`Optional` The minimum TLS version supported by the storage account. Defaults to `TLS1_2`)

  `cross_tenant_replication_enabled`  = (`Optional` Should cross Tenant replication be enabled? Defaults to `true`.)

  `shared_access_key_enabled` = (`Optional` Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. Defaults to `true`. )

  `default_to_oauth_authentication` = (`Optional` Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false`)

  `queue_encryption_key_type` = (`Optional` The encryption type of the queue service. Default value is `Service`.)

  `table_encryption_key_type` = (`Optional` The encryption type of the table service. Default value is `Service`.)

  `infrastructure_encryption_enabled` = (`Optional` Is infrastructure encryption enabled? Defaults to `false`.)

  `allowed_copy_scope` = (`Optional` Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet.)

  `sftp_enabled` = (`Optional` Enable SFTP for the storage account.)

  `blob_properties` = (`Optional` A blob_properties block as defined below.)

  `versioning_enabled` = (`Optional` Specifies whether versioning is enabled for the Blob service. Defaults to `true`)

  `change_feed_enabled` = (`Optional` Specifies whether change feed is enabled for the Blob service. Defaults to `true`)

  `change_feed_retention_in_days` = (`Optional` The duration of change feed events retention in days.)

  `default_service_version` = (`Optional` The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version.)

  `last_access_time_enabled` = (`Optional` Is the last access time based tracking enabled? Default to `false`.)

  `delete_retention_policy` = (`Optional` A delete_retention_policy block as defined below.)

  `days` = (`Optional` Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to `7`)

  `container_delete_retention_policy` = (`Optional` A container_delete_retention_policy block as defined below.)

  `days` = (`Optional` Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to `7`.)

  `restore_policy` = (`Optional` A restore_policy block as defined below.)

  `days` = (`Required` Specifies the number of days that the blob can be restored, between 1 and 365 days. This must be less than the days specified for delete_retention_policy.)

  `cors_rule` = (`Optional` A cors_rule block as defined below.)

  `allowed_headers` = (`Required` A list of headers that are allowed to be a part of the cross-origin request.)

  `allowed_methods` = (`Required` A list of HTTP methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.)

  `allowed_origins` = (`Required` A list of origin domains that will be allowed by CORS.)

  `exposed_headers` = (`Required` A list of response headers that are exposed to CORS clients.)

  `max_age_in_seconds` = (`Required` The number of seconds the client should cache a preflight response.)

  `queue_properties` = (`Optional` A queue_properties block as defined below.)

  `logging` = (`Optional` A logging block as defined below.)

  `delete` = (`Required` Indicates whether all delete requests should be logged.)

  `read` = (`Required` Indicates whether all read requests should be logged.)

  `version` = (`Required` The version of storage analytics to configure.)

  `write` = (`Required` Indicates whether all write requests should be logged.)

  `retention_policy_days` = (`Optional` Specifies the number of days that logs will be retained.)

  `minute_metrics` = (`Optional` A minute_metrics block as defined below.)

  `enabled` = (`Required` Indicates whether minute metrics are enabled for the Queue service.)

  `version` = (`Required` The version of storage analytics to configure.)

  `include_apis` = (`Optional` Indicates whether metrics should generate summary statistics for called API operations.)

  `retention_policy_days` = (`Optional` Specifies the number of days that logs will be retained.)

  `hour_metrics` = (`Optional` A hour_metrics block as defined below.)

  `enabled` = (`Required` Indicates whether hour metrics are enabled for the Queue service.)

  `version` = (`Required` The version of storage analytics to configure.)

  `include_apis` = (`Optional` Indicates whether metrics should generate summary statistics for called API operations.)

  `retention_policy_days` = (`Optional` Specifies the number of days that logs will be retained.)

  `share_properties` = (`Optional` A share_properties block as defined below.)

  `retention_policy` = (`Optional` A retention_policy block as defined below.)

  `days` = (`Optional` Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to `7`.)

  `smb` = (`Optional` A smb block as defined below.)

  `versions` = (`Optional` A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.)

  `authentication_types` = (`Optional` A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.)

  `kerberos_ticket_encryption_type` = (`Optional` A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.)

  `channel_encryption_type` = (`Optional` A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.)

  `multichannel_enabled` = (`Optional` Indicates whether multichannel is enabled. Defaults to `false`. This is only supported on Premium storage accounts.)

  `static_website` = (`Optional` A static_website block as defined below.)

  `index_document` = (`Optional` The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.)

  `error_404_document` = (`Optional` The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.)

  `custom_domain` = (`Optional` A custom_domain block as documented below.)

  `name` = (`Required` The Custom Domain Name to use for the Storage Account, which will be validated by Azure.)

  `use_subdomain` = (`Optional` Should the Custom Domain Name be validated by using indirect CNAME validation?)

  `immutability_policy` = (`Optional` An immutability_policy block as defined below.)

  `allow_protected_append_writes` = (`Required` When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance.)

  `state` = (`Required` Defines the mode of the policy.)

  `period_since_creation_in_days` = (`Required` The immutability period for the blobs in the container since the policy creation, in days.)

  `network_rules` = (`Optional` A network_rules block as documented below.)

  `default_action` = (`Optional` The default action when no rules match traffic. Defaults to `Deny`)

  `bypass` = (`Optional` Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Defaults to `Logging`, `Metrics`, `AzureServices`)

  `ip_rules` = (`Optional` The list of IP rules for the storage account. Defaults to `155.198.30.0/23`, `146.179.32.0/21`, `20.77.153.220`, `20.77.153.167`, `20.77.153.187`, `20.77.153.237`, `51.132.159.227`, `20.56.147.101`)

  `custom_ip_rules` = (`Optional` The list of custom IP rules for the storage account.)

  `identity` = (`Optional` An identity block as defined below.)

  `type` = (`Required` Specifies the type of Managed Service Identity that should be configured on this Storage Account.)

  `routing` = (`Optional` A routing block as defined below.)

  `choice` = (`Optional` Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to `MicrosoftRouting`.)

  `publish_microsoft_endpoints` = (`Optional` Should Microsoft routing storage endpoints be published? Defaults to `false`.)

  `publish_internet_endpoints` = (`Optional` Specifies whether to publish Internet endpoints.)
  EOF
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = optional(string, "uksouth")
    account_kind                      = optional(string)
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = optional(string)
    public_network_access_enabled     = optional(bool)
    enable_https_traffic_only         = optional(bool, true)
    is_hns_enabled                    = optional(bool)
    allow_nested_items_to_be_public   = optional(bool, false)
    nfsv3_enabled                     = optional(bool)
    large_file_share_enabled          = optional(bool, true)
    min_tls_version                   = optional(string, "TLS1_2")
    cross_tenant_replication_enabled  = optional(bool)
    shared_access_key_enabled         = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    allowed_copy_scope                = optional(string)
    sftp_enabled                      = optional(bool)

    blob_properties = optional(object({
      versioning_enabled            = optional(bool)
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)

      delete_retention_policy = optional(object({
        days = optional(number)
      }))

      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))

      restore_policy = optional(object({
        days = optional(number)
      }))

      cors_rule = optional(object({
        allowed_headers    = string
        allowed_methods    = string
        allowed_origins    = string
        exposed_headers    = string
        max_age_in_seconds = number
      }))
    }))

    queue_properties = optional(object({
      minute_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))

      cors_rule = optional(object({
        allowed_headers    = string
        allowed_methods    = string
        allowed_origins    = string
        exposed_headers    = string
        max_age_in_seconds = number
      }))

      logging = optional(object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = optional(number)
      }))

      hour_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
    }))

    share_properties = optional(object({
      cors_rule = optional(object({
        allowed_headers    = string
        allowed_methods    = string
        allowed_origins    = string
        exposed_headers    = string
        max_age_in_seconds = number
      }))

      retention_policy = optional(object({
        days = optional(number)
      }))

      smb = optional(object({
        versions                        = optional(string)
        authentication_types            = optional(string)
        kerberos_ticket_encryption_type = optional(string)
        channel_encryption_type         = optional(string)
        multichannel_enabled            = optional(bool)
      }))
    }))

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))

    immutability_policy = optional(object({
      allow_protected_append_writes = bool
      state                         = string
      period_since_creation_in_days = number
    }))

    network_rules = optional(object({
      default_action             = optional(string, "Deny")
      bypass                     = optional(list(string), ["Logging", "Metrics", "AzureServices"])
      ip_rules                   = optional(list(string), ["20.77.153.220", "20.77.153.167", "20.77.153.187", "20.77.153.237", "51.132.159.227", "20.56.147.101"])
      custom_ip_rules            = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string))
      private_link_access        = optional(list(map(string)), [])
    }), {})

    identity = optional(object({
      type = string
    }))

    routing = optional(object({
      choice                      = optional(string)
      publish_microsoft_endpoints = optional(bool)
      publish_internet_endpoints  = optional(bool)
    }))
  }))
  default = {}
}

variable "storage_shares" {
  description = <<-EOF
  Parameters used to create `Azure file shares`

  `name` = (`Required` The name of the Azure file share.)

  `access_tier` = (`Optional` The access tier of the File Share. Possible values are Hot, Cool and TransactionOptimized, Premium.)

  `enabled_protocol` = (`Optional` The protocol used for the share. Possible values are SMB and NFS.)

  `storage_account_name` = (`Required` The storage account name in which the file share needs to be created.)

  `quota` = (`Required` The quota of the Azure file share.)

  `acl` = (`Optional` One or more acl blocks as defined below.)

  `id` = (`Required` The ID which should be used for this Shared Identifier.)

  `access_policy` = (`Optional` An access_policy block as defined below.)

  `permissions` = (`Required` The permissions which should be associated with this Shared Identifier. Possible value is combination of r (read), w (write), d (delete), and l (list).)

  `start` = (`Optional` The time at which this Access Policy should be valid from, in ISO8601 format.)

  `expiry` = (`Optional` The time at which this Access Policy should be valid until, in ISO8601 format.)
  EOF
  type = map(object({
    name                 = string
    access_tier          = optional(string)
    enabled_protocol     = optional(string)
    storage_account_name = string
    quota                = number
    acl = optional(object({
      id = string
      access_policy = optional(object({
        permissions = string
        start       = optional(string)
        expiry      = optional(string)
      }))
    }))
  }))
  default = null
}

variable "storage_data_lake_gen2_filesystem" {
  description = <<-EOF
  Parameters used to create `Azure Data Lake Gen2 Filesystems`

  `name` = (`Required` The name of the Azure Data Lake Gen2 Filesystems.)

  `storage_account_name` = (`Required` The storage account name in which the Gen2 filesystem needs to be created.)

  `resource_group_name` = (`Required` The storage account resource group name.)

  `properties` = (`Optional` A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System.)

  `ace` = (`Optional` One or more ace blocks as defined below to specify the entries for the ACL for the path.)

  `scope` = (`Optional` Specifies whether the ACE represents an access entry or a default entry. Default value is access.)

  `type` = (`Required` Specifies the type of entry. Can be user, group, mask or other.)

  `permissions` = (`Required` Specifies the permissions for the entry in rwx form. For example, rwx gives full permissions but r-- only gives read permissions.)

  EOF
  type = map(object({
    name                 = string
    storage_account_name = string
    resource_group_name  = string
    properties           = optional(map(string))
    ace = optional(object({
      scope       = optional(string)
      type        = string
      permissions = string
    }))
  }))
  default = null
}

variable "storage_containers" {
  description = <<-EOF
  Parameters used to create `Azure Storage Containers`

  `name` = (`Required` The name of the Azure Storage Containers. )

  `storage_account_name` = (`Required` The name of the storage account in which the container needs to be created.)

  `container_access_type` = (`Required` The Access Level configured for this Container. Possible values are `blob`, `container` or `private`.)
  EOF
  type = map(object({
    name                  = string
    storage_account_name  = string
    container_access_type = string
  }))
  default = null
}

variable "user_assigned_identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to MSSQL server."
  type        = list(string)
  default     = null
}

variable "data_lake_owner_id" {
  description = "Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /)."
  type        = string
  default     = null
}

variable "data_lake_id" {
  description = "Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for user or group entries."
  type        = string
  default     = null
}

variable "data_lake_group_id" {
  description = "Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). "
  type        = string
  default     = null
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
