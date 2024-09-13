# Key Vault Secret
The module allows you to create an Azure Key Vault secret and set its value.  For more information on Key Vault secret, please refer to [Azure Key Vault Secret](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/key_vault_secret)

### Usage
```
module "key-vault-secret" {
  source                  = "app.terraform.io/<TFC Org>/key-vault-secret/azurerm"
  version                 = "x.x.x"
  keyvault_secret_config  = var.keyvault_secret_config
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
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_client_config"></a> [azurerm\_client\_config](#input\_azurerm\_client\_config) | AzureRM provider configuration | `any` | n/a | yes |
| <a name="input_keyvault_secret_config"></a> [keyvault\_secret\_config](#input\_keyvault\_secret\_config) | Parameters used to configure `keyvault secret config`<br>  `name` = (`Required` Specifies the name of the Key Vault Secret.)<br><br>  `content_type` = (`Optional` Specifies the content type for the Key Vault Secret.)<br><br>  `not_before_date` = (`Optional` Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').)<br><br>  `expiration_date` = (`Optional` Expiration UTC datetime (Y-m-d'T'H:M:S'Z').)<br><br>  `kv_resource_group_name` = (`Required` Name of the resource group in which Keyvault exists)<br><br>  `kv_name` = (`Required` Name of the Keyvault to store the secret) | <pre>map(object({<br>    name                   = string<br>    secret_value           = optional(string)<br>    content_type           = optional(string)<br>    not_before_date        = optional(string)<br>    expiration_date        = optional(string)<br>    kv_resource_group_name = string<br>    kv_name                = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Key Vault Secret. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Key Vault Secret. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource ID of the Azure Key Vault Secret. |
| <a name="output_secret_value"></a> [secret\_value](#output\_secret\_value) | The value of the Azure Key Vault Secret. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->