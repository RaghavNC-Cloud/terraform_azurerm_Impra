variable "key_vaults" {
  description = <<-EOF
  Parameters used to create `Azure Key Vault`

  `name` = (`Required` The name of the key vault.)

  `location` = (`Required` The Azure region where the key vault will be created. Defaults to `uksouth`)

  `resource_group_name` = (`Required` The name of the resource group in which to create the key vault.)

  `sku_name` = (`optional` The SKU (pricing tier) of the key vault. Defaults to `standard`)

  `enabled_for_disk_encryption` = (`Optional` Specifies whether Azure Disk Encryption is enabled for the key vault. Defaults to `false`)

  `soft_delete_retention_days` = (`Optional` The number of days that deleted keys, secrets, and certificates should be retained. Defaults to `90`)

  `purge_protection_enabled` = (`Optional` Specifies whether the key vault is protected against purging. Defaults to `false`)

  `public_network_access_enabled` = (`Optional` Specifies whether the key vault is accessible from public networks. Defaults to `false`)

  `enable_rbac_authorization` = (`Optional` Specifies whether Azure RBAC authorization is enabled for the key vault. Defaults to `false`)

  `enabled_for_deployment` = (`Optional` Specifies whether the key vault is enabled for resource deployment. Defaults to `false`)

  `enabled_for_template_deployment` = (`Optional` Specifies whether the key vault is enabled for template deployment. Defaults to `false`)

  `network_acls` = (`Optional` The network access control settings for the key vault.)

  `bypass` = (`Optional` Specifies which traffic should bypass network rules. Defaults to `AzureServices`)

  `default_action` = (`Optional` Specifies the default action when no rules match traffic. Defaults to `Deny`)

  `ip_rules` = (`Optional` The list of IP rules for the key vault. Defaults to `155.198.30.0/23`, `146.179.32.0/21`, `20.77.153.220`, `20.77.153.167`, `20.77.153.187`, `20.77.153.237`, `51.132.159.227`, `20.56.147.101`)

  `custom_ip_rules` = (`Optional` One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.)

  `virtual_network_subnet_ids` = (`Optional` One or more Subnet IDs which should be able to access this Key Vault.)
  EOF
  type = map(object({
    name                            = string
    location                        = optional(string, "uksouth")
    resource_group_name             = string
    sku_name                        = optional(string, "standard")
    enabled_for_disk_encryption     = optional(bool)
    soft_delete_retention_days      = optional(number, 90)
    purge_protection_enabled        = optional(bool, true)
    public_network_access_enabled   = optional(bool, true)
    enable_rbac_authorization       = optional(bool)
    enabled_for_deployment          = optional(bool)
    enabled_for_template_deployment = optional(bool)

    network_acls = optional(object({
      bypass                     = optional(string, "AzureServices")
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string), ["20.77.153.220/32", "20.77.153.167/32", "20.77.153.187/32", "20.77.153.237/32", "51.132.159.227/32", "20.56.147.101/32"])
      custom_ip_rules            = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string))
    }), {})
  }))
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
