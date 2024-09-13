# Private Endpoint

The module allows you to create Private Endpoints and its dependent resources for various Azure resources. This includes [Private Endpoints](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint).

##Usage
```
module "private_endpoints" {
  source               = "app.terraform.io/Imperial-College/private-endpoints/azurerm"
  version              = "x.x.x"
  private_endpoints    = var.private_endpoints
  pep_subnet_id        = var.pep_subnet_id
  pep_pvt_dns_zone_ids = var.pep_pvt_dns_zone_ids
  pep_pvt_resource_id  = var.pep_pvt_resource_id
  tags                 = var.tags
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
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Parameters used to create `Azure Key Vault Private Endpoint`<br><br>`name` = (The name of the Key Vault Private Endpoint.)<br><br>`resource_group_name` = (The name of the resource group in which to create the Key Vault Private Endpoint.)<br><br>`location` = (The Azure region where the Key Vault Private Endpoint will be created.Defaults to `uksouth`)<br><br>`subnet_id` = (`Required` Subnet ID for private Endpoint)<br><br>`private_dns_zone_group` - (`Optional` A private\_dns\_zone\_group block as defined below.)<br><br>`private_dns_zone_ids` - (`Required` Specifies the list of Private DNS Zones to include within the private\_dns\_zone\_group.)<br><br>`private_service_connection` = (The private service connection settings for the Key Vault Private Endpoint.)<br><br>`private_connection_resource_id` - (`Required` The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to.)<br><br>`is_manual_connection` = (`Optional`Does the Private Endpoint require Manual Approval from the remote resource owner? Defaults to `false`)<br><br>`subresource_names` = (`Required` The list of subresource names associated with the private service connection.) | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    location            = optional(string, "uksouth")<br>    subnet_id           = string<br><br>    private_dns_zone_group = object({<br>      private_dns_zone_ids = list(string)<br>    })<br><br>    private_service_connection = object({<br>      private_connection_resource_id = string<br>      is_manual_connection           = optional(bool, false)<br>      subresource_names              = list(string)<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoint_fqdn"></a> [private\_endpoint\_fqdn](#output\_private\_endpoint\_fqdn) | The fully qualified domain name(s) of the Azure Private Endpoint(s). |
| <a name="output_private_endpoint_fqdn_with_https"></a> [private\_endpoint\_fqdn\_with\_https](#output\_private\_endpoint\_fqdn\_with\_https) | The fully qualified domain name(s) of the Azure Private Endpoint(s) with https://. |
| <a name="output_private_endpoint_id"></a> [private\_endpoint\_id](#output\_private\_endpoint\_id) | The unique identifier(s) of the Azure Private Endpoint(s). |
| <a name="output_private_endpoint_name"></a> [private\_endpoint\_name](#output\_private\_endpoint\_name) | The name(s) of the Azure Private Endpoint(s). |
| <a name="output_private_endpoint_private_ip_address"></a> [private\_endpoint\_private\_ip\_address](#output\_private\_endpoint\_private\_ip\_address) | The private IP address(es) associated with the Private Endpoint(s). |
| <a name="output_private_endpoint_resource_group_name"></a> [private\_endpoint\_resource\_group\_name](#output\_private\_endpoint\_resource\_group\_name) | The name of the Azure resource group in which the Private Endpoint(s) is located. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->