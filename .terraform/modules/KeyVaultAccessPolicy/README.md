# Azure Key Vault

The module allows you to access policy on Azure key Vault. For more information on Key Vault Access Policy, please refer to [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)

## Usage
```
module "key-vault" {
  source                  = "app.terraform.io/<TFC Org Name>/key-vault/azurerm"
  version                 = "x.x.x"
  kv_access_policy        = var.kv_access_policy
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_client_config"></a> [azurerm\_client\_config](#input\_azurerm\_client\_config) | AzureRM provider configuration | `any` | n/a | yes |
| <a name="input_kv_access_policy"></a> [kv\_access\_policy](#input\_kv\_access\_policy) | Parameters used to configure `Keyvault Access Policy`<br><br>  `object_id` = (`Required` The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.)<br><br>  `keyvault_resource_group_name` = (`Required` Name of the keyvault resource group)<br><br>  `keyvault_name` = (`Required` Name of the keyvault)<br><br>  `application_id` = (`Optional` The object ID of an Application in Azure Active Directory.)<br><br>  `key_permissions` = (`Optional` List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy, and SetRotationPolicy.)<br><br>  `secret_permissions` = (`Optional` List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.)<br><br>  `certificate_permissions` = (`Optional` List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update.)<br><br>  `storage_permissions` = (`Optional` List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update.) | <pre>map(object({<br>    object_id                    = string<br>    keyvault_resource_group_name = string<br>    keyvault_name                = string<br>    application_id               = optional(string)<br>    key_permissions              = optional(list(string))<br>    secret_permissions           = optional(list(string))<br>    certificate_permissions      = optional(list(string))<br>    storage_permissions          = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The Application ID associated with the Azure Key Vault Access Policy. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the Azure Key Vault Access Policy. |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Azure Key Vault to which the Access Policy is applied. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The Object ID associated with the Azure Key Vault Access Policy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->