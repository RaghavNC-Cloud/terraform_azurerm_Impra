# Azure Key Vault
The module allows you to create one or multiple Azure Key Vaults and their dependent resources along with setting up access policies for them. For more information on Key Vault, please refer to [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)

## Usage
```hcl
module "key-vault" {
  source                  = "app.terraform.io/<TFC Org name>/key-vault/azurerm"
  version                 = "x.x.x"
  key_vaults              = var.key_vaults
  tags                    = var.tags
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.51 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/key_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_client_config"></a> [azurerm\_client\_config](#input\_azurerm\_client\_config) | AzureRM provider configuration | `any` | n/a | yes |
| <a name="input_key_vaults"></a> [key\_vaults](#input\_key\_vaults) | Parameters used to create `Azure Key Vault`<br><br>`name` = (`Required` The name of the key vault.)<br><br>`location` = (`Required` The Azure region where the key vault will be created. Defaults to `uksouth`)<br><br>`resource_group_name` = (`Required` The name of the resource group in which to create the key vault.)<br><br>`sku_name` = (`optional` The SKU (pricing tier) of the key vault. Defaults to `standard`)<br><br>`enabled_for_disk_encryption` = (`Optional` Specifies whether Azure Disk Encryption is enabled for the key vault. Defaults to `false`)<br><br>`soft_delete_retention_days` = (`Optional` The number of days that deleted keys, secrets, and certificates should be retained. Defaults to `90`)<br><br>`purge_protection_enabled` = (`Optional` Specifies whether the key vault is protected against purging. Defaults to `false`)<br><br>`public_network_access_enabled` = (`Optional` Specifies whether the key vault is accessible from public networks. Defaults to `false`)<br><br>`enable_rbac_authorization` = (`Optional` Specifies whether Azure RBAC authorization is enabled for the key vault. Defaults to `false`)<br><br>`enabled_for_deployment` = (`Optional` Specifies whether the key vault is enabled for resource deployment. Defaults to `false`)<br><br>`enabled_for_template_deployment` = (`Optional` Specifies whether the key vault is enabled for template deployment. Defaults to `false`)<br><br>`network_acls` = (`Optional` The network access control settings for the key vault.)<br><br>`bypass` = (`Optional` Specifies which traffic should bypass network rules. Defaults to `AzureServices`)<br><br>`default_action` = (`Optional` Specifies the default action when no rules match traffic. Defaults to `Deny`)<br><br>`ip_rules` = (`Optional` The list of IP rules for the key vault. Defaults to `155.198.30.0/23`, `146.179.32.0/21`, `20.77.153.220`, `20.77.153.167`, `20.77.153.187`, `20.77.153.237`, `51.132.159.227`, `20.56.147.101`)<br><br>`custom_ip_rules` = (`Optional` One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.)<br><br>`virtual_network_subnet_ids` = (`Optional` One or more Subnet IDs which should be able to access this Key Vault.) | <pre>map(object({<br>    name                            = string<br>    location                        = optional(string, "uksouth")<br>    resource_group_name             = string<br>    sku_name                        = optional(string, "standard")<br>    enabled_for_disk_encryption     = optional(bool)<br>    soft_delete_retention_days      = optional(number, 90)<br>    purge_protection_enabled        = optional(bool, true)<br>    public_network_access_enabled   = optional(bool, true)<br>    enable_rbac_authorization       = optional(bool)<br>    enabled_for_deployment          = optional(bool)<br>    enabled_for_template_deployment = optional(bool)<br><br>    network_acls = optional(object({<br>      bypass                     = optional(string, "AzureServices")<br>      default_action             = optional(string, "Deny")<br>      ip_rules                   = optional(list(string), ["20.77.153.220/32", "20.77.153.167/32", "20.77.153.187/32", "20.77.153.237/32", "51.132.159.227/32", "20.56.147.101/32"])<br>      custom_ip_rules            = optional(list(string), [])<br>      virtual_network_subnet_ids = optional(list(string))<br>    }), {})<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique identifier(s) of the Azure Key Vault(s). |
| <a name="output_name"></a> [name](#output\_name) | The name(s) of the Azure Key Vault(s). |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Azure resource group in which the Azure Key Vault(s) is located. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID associated with the Azure Key Vault(s). |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI(s) of the Azure Key Vault(s). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->