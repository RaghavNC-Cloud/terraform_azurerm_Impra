# Azure Resource Group

The module allows you to create one or multiple Azure Resource Groups. For more information on Azure Resource Group, please refer to [Azure Resource Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

## Usage
```hcl
module "resource-group" {
  source          = "app.terraform.io/<TFC Org Name>/resource-group/azurerm"
  version         = "x.x.x"
  resource_groups = var.resource_groups
  tags            = var.tags
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Parameters used to create `Resource Group`<br>`name`     = (`Required` The name of the resource group.)<br><br>`location` = (`Required` The location where the resource group should be created. Defaults to `uksouth`) | <pre>map(object({<br>    name     = string<br>    location = optional(string, "uksouth")<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | A list of unique identifiers for the Azure Resource Groups. |
| <a name="output_location"></a> [location](#output\_location) | A list of locations (regions) where the Azure Resource Groups are created. |
| <a name="output_name"></a> [name](#output\_name) | A list of names of the Azure Resource Groups. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->