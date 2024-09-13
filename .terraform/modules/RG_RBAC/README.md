# Role-Based Access Control

The module allows you to create an Role-Based Access Control Assignment. For more information on Role-Based Access Control, please refer to [Role-Based Access Control](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/role_assignment)

### Usage
```
locals {
  # Data block to get AD groups
  data "azuread_groups" "this" {
    display_names = ["Group A", "Group B"]
  }

  # Data block to get AD Service Principals
  data "azuread_service_principals" "this" {
    display_names = ["SPN A", "SPN B"]
  }

  # Get AD group object IDs
  group_object_ids = {
    for k, v in data.azuread_groups.this.display_names :
    v => data.azuread_groups.this.object_ids[k]
  }

  spn_object_ids = {
    for k, v in data.azuread_service_principals.this.display_names :
    v => data.azuread_service_principals.this.object_ids[k]
  }

  rbac_config = {
    0 = {
      role_definition_name = "Reader"
      scope                = azurerm_resource_group.example.id
      object_id            = local.group_object_ids["Group A"]
    }
    1 = {
      role_definition_name = "Contributor"
      scope                = azurerm_resource_group.example.id
      object_id            = local.spn_object_ids["SPN A"]
    }
    2 = {
      role_definition_name = "Reader"
      scope                = azurerm_resource_group.example.id
      object_id            = local.group_object_ids["Group B"]
    }
    3 = {
      role_definition_name = "Contributor"
      scope                = azurerm_resource_group.example.id
      object_id            = local.spn_object_ids["SPN B"]
    }
  }
}

module "key-vault-rbac" {
  source               = "app.terraform.io/<TFC Org name>/rbac/azurerm"
  version              = "x.x.x"
  rbac_config          = local.rbac_config
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.6 |
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
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rbac_config"></a> [rbac\_config](#input\_rbac\_config) | `role_definition_name` -  (`Optional` The name of a built-in Role. Changing this forces a new resource to be created.)<br><br>`scope` - (`Required` The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG.)<br><br>`object_id` - (`Required` The object ID of the group or user or service principle (Enterprise application object ID) to assign the Role Definition to.)<br><br>`skip_service_principal_aad_check` (`Optional` If the principal\_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal\_id is a Service Principal identity. Defaults to `false`.) | <pre>map(object({<br>    role_definition_name             = string<br>    scope                            = string<br>    object_id                        = string<br>    skip_service_principal_aad_check = optional(bool, false)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique identifier for the Azure Role Assignment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Role Assignment. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The ID of the principal (user, group, service principal, or managed identity) to whom the role is assigned. |
| <a name="output_role_definition_id"></a> [role\_definition\_id](#output\_role\_definition\_id) | The ID of the Azure Role Definition used in the role assignment. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->