# Variables
variable "kv_access_policy" {
  description = <<-EOF
  Parameters used to configure `Keyvault Access Policy`

    `object_id` = (`Required` The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.)

    `keyvault_resource_group_name` = (`Required` Name of the keyvault resource group)

    `keyvault_name` = (`Required` Name of the keyvault)

    `application_id` = (`Optional` The object ID of an Application in Azure Active Directory.)

    `key_permissions` = (`Optional` List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.)

    `secret_permissions` = (`Optional` List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.)

    `certificate_permissions` = (`Optional` List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.)

    `storage_permissions` = (`Optional` List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.)
  EOF
  type = map(object({
    object_id                    = string
    keyvault_resource_group_name = string
    keyvault_name                = string
    application_id               = optional(string)
    key_permissions              = optional(list(string))
    secret_permissions           = optional(list(string))
    certificate_permissions      = optional(list(string))
    storage_permissions          = optional(list(string))
  }))
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
}
