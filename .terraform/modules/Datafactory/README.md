# Azure Data Factory
The module allows you to create one or multiple Azure Data Factories and their dependent resources. For more information on Azure Data Factory parameters, please refer to [Azure Data Factory Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory)

## Usage
```hcl
module "data-factory" {
  source = "app.terraform.io/Imperial-College/data-factory/azurerm"
  version                                 = "x.x.x"
  adf_config                              = var.adf_config
  adf_pe_config                           = var.adf_pe_config
  integration_runtime_type                = var.integration_runtime_type
  integration_runtime_configuration_azure = var.integration_runtime_configuration_azure
  tags                                    = var.tags
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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/data_factory) | resource |
| [azurerm_data_factory_integration_runtime_azure.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/data_factory_integration_runtime_azure) | resource |
| [azurerm_data_factory_integration_runtime_azure_ssis.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/data_factory_integration_runtime_azure_ssis) | resource |
| [azurerm_data_factory_integration_runtime_self_hosted.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/data_factory_integration_runtime_self_hosted) | resource |
| [azurerm_data_factory_managed_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.51/docs/resources/data_factory_managed_private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adf_config"></a> [adf\_config](#input\_adf\_config) | Parameters used to configure `Azure Data Factory`<br><br>  `name` - (`Required` Specifies the name of the Data Factory.)<br><br>  `location` - (`Optional` Specifies the supported Azure location where the resource exists. `required`, defaults to `uksouth`)<br><br>  `resource_group_name` - (`Required` The name of the resource group in which to create the Data Factory.)<br><br>  `managed_virtual_network_enabled` - (`Optional` Is Managed Virtual Network enabled? `optional`, defaults to `true`)<br><br>  `public_network_enabled` - (`Optional` Is the Data Factory visible to the public network? `optional`, defaults to `false`)<br><br>  `github_configuration` - (`Optional` Github block defined below)<br><br>  `account_name` - (`Required` Specifies the GitHub account name.)<br><br>  `git_url` - (`Required` Specifies the GitHub Enterprise host name.)<br><br>  `repository_name` - (`Required` Specifies the name of the git repository.)<br><br>  `root_folder` - (`Required` Specifies the root folder within the repository.)<br><br>  `vsts_configuration` - (`Optional` VSTS configuration block defined below)<br><br>  `branch_name` - (`Required` Specifies the branch of the repository to get code from.)<br><br>  `account_name` - (`Required` Specifies the VSTS account name.)<br><br>  `branch_name - (`Required` Specifies the branch of the repository to get code from.)<br><br>  `project\_name` - (`Required` Specifies the name of the VSTS project.)<br><br>  `repository\_name` - (`Required` Specifies the name of the git repository.)<br><br>  `root\_folder` - (`Required` Specifies the root folder within the repository.)<br><br>  `tenant\_id` - (`Required` Specifies the Tenant ID associated with the VSTS account.)<br>` | <pre>map(object({<br>    name                            = string<br>    location                        = optional(string, "uksouth")<br>    resource_group_name             = string<br>    managed_virtual_network_enabled = optional(bool)<br>    public_network_enabled          = optional(bool)<br>    github_configuration = optional(object({<br>      account_name    = string<br>      branch_name     = string<br>      git_url         = string<br>      repository_name = string<br>      root_folder     = string<br>    }))<br>    vsts_configuration = optional(object({<br>      account_name    = string<br>      branch_name     = string<br>      project_name    = string<br>      repository_name = string<br>      root_folder     = string<br>      tenant_id       = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_adf_pe_config"></a> [adf\_pe\_config](#input\_adf\_pe\_config) | Parameters used to configure `datafactory managed private endpoints`<br><br>  `name` - (`Required` Specifies the name which should be used for this Managed Private Endpoint. Changing this forces a new resource to be created.)<br><br>  `data_factory_name` - (`Required` Name of the datafactory.)<br><br>  `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists.)<br><br>  `target_resource_id` - (`Required` The ID of the Private Link Enabled Remote Resource which this Data Factory Private Endpoint should be connected to. Changing this forces a new resource to be created.)<br><br>  `subresource_name` - (`Optional` Specifies the sub resource name which the Data Factory Private Endpoint is able to connect to. Changing this forces a new resource to be created.)<br><br>  `fqdns` - (`Optional` Fully qualified domain names. Changing this forces a new resource to be created.) | <pre>map(object({<br>    name                        = string<br>    data_factory_name           = string<br>    data_factory_resource_group = string<br>    target_resource_id          = string<br>    subresource_name            = optional(string)<br>    fqdns                       = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_azurerm_client_config"></a> [azurerm\_client\_config](#input\_azurerm\_client\_config) | AzureRM provider configuration | `any` | `null` | no |
| <a name="input_integration_runtime_configuration_azure"></a> [integration\_runtime\_configuration\_azure](#input\_integration\_runtime\_configuration\_azure) | Parameters used to configure `Azure` integration runtime<br>    `data_factory_name` - (`Required` Name of the datafactory)<br><br>    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists)<br><br>    `name` - (`Required` Specifies the name of the Managed Integration Runtime.)<br><br>    `location` - (`Required` Specifies the supported Azure location where the resource exists.)<br><br>    `description` - (`Optional` Integration runtime description.)<br><br>    `cleanup_enabled` (`Optional` Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Defaults to `true`)<br><br>    `compute_type` (`Optional` Compute type of the cluster which will execute data flow job. Defaults to `General`)<br><br>    `core_count` (`Optional` Core count of the cluster which will execute data flow job. Defaults to `8`)<br><br>    `time_to_live_min` (`Optional` Time to live (in minutes) setting of the cluster which will execute data flow job. Defaults to `0`)<br><br>    `virtual_network_enabled` (`Optional` Is Integration Runtime compute provisioned within Managed Virtual Network? Defaults to `false`) | <pre>map(object({<br>    data_factory_name           = string<br>    data_factory_resource_group = string<br>    name                        = string<br>    location                    = string<br>    description                 = optional(string)<br>    cleanup_enabled             = optional(bool)<br>    compute_type                = optional(string)<br>    core_count                  = optional(number)<br>    time_to_live_min            = optional(number)<br>    virtual_network_enabled     = optional(bool)<br>  }))</pre> | `null` | no |
| <a name="input_integration_runtime_configuration_azure_self_hosted"></a> [integration\_runtime\_configuration\_azure\_self\_hosted](#input\_integration\_runtime\_configuration\_azure\_self\_hosted) | Parameters used to configure `Azure` integration runtime<br>    `data_factory_name` - (`Required` Name of the datafactory)<br><br>    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists)<br><br>    `name` - (`Required` Specifies the name of the Managed Integration Runtime.)<br><br>    `description` - (`Optional` Integration runtime description.) | `list(map(string))` | `null` | no |
| <a name="input_integration_runtime_configuration_azure_ssis"></a> [integration\_runtime\_configuration\_azure\_ssis](#input\_integration\_runtime\_configuration\_azure\_ssis) | Parameters used to configure `AzureSSIS` integration runtime:<br><br>    `data_factory_name` - (`Required` Name of the datafactory.)<br><br>    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists.)<br><br>    `name` - (`Required` Specifies the name of the Azure-SSIS Integration Runtime.)<br><br>    `location` - (`Required` Specifies the supported Azure location where the resource exists.)<br><br>    `description` - (`Optional` Integration runtime description.)<br><br>    `node_size` - (`Required` The size of the nodes on which the Azure-SSIS Integration Runtime runs.)<br><br>    `number_of_nodes` - (`Optional` Number of nodes for the Azure-SSIS Integration Runtime. Defaults to `1`)<br><br>    `max_parallel_executions_per_nodes` - (`Optional` Defines the maximum parallel executions per node. Defaults to `1`)<br><br>    `edition` - (`Optional` The Azure-SSIS Integration Runtime edition. Defaults to `Standard`)<br><br>    `license_type` - (`Optional` The type of the license that is used. Defaults to `LicenseIncluded`) | <pre>map(object({<br>    data_factory_name                = string<br>    data_factory_resource_group      = string<br>    name                             = string<br>    location                         = string<br>    description                      = optional(string)<br>    node_size                        = string<br>    number_of_nodes                  = optional(number)<br>    max_parallel_executions_per_node = optional(number)<br>    edition                          = optional(string)<br>    license_type                     = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_factory_id"></a> [data\_factory\_id](#output\_data\_factory\_id) | Azure Datafactory ID |
| <a name="output_data_factory_identity"></a> [data\_factory\_identity](#output\_data\_factory\_identity) | Azure datafactory identity |
| <a name="output_data_factory_integration_runtime_azure_id"></a> [data\_factory\_integration\_runtime\_azure\_id](#output\_data\_factory\_integration\_runtime\_azure\_id) | The ID of the Data Factory Azure Integration Runtime. |
| <a name="output_data_factory_integration_runtime_azure_ssis_id"></a> [data\_factory\_integration\_runtime\_azure\_ssis\_id](#output\_data\_factory\_integration\_runtime\_azure\_ssis\_id) | The ID of the Data Factory Azure-SSIS Integration Runtime. |
| <a name="output_data_factory_integration_runtime_self_hosted_id"></a> [data\_factory\_integration\_runtime\_self\_hosted\_id](#output\_data\_factory\_integration\_runtime\_self\_hosted\_id) | The ID of the Data Factory Self Hosted Integration Runtime. |
| <a name="output_data_factory_integration_runtime_self_hosted_primary_authorization_key"></a> [data\_factory\_integration\_runtime\_self\_hosted\_primary\_authorization\_key](#output\_data\_factory\_integration\_runtime\_self\_hosted\_primary\_authorization\_key) | The primary integration runtime authentication key. |
| <a name="output_data_factory_integration_runtime_self_hosted_secondary_authorization_key"></a> [data\_factory\_integration\_runtime\_self\_hosted\_secondary\_authorization\_key](#output\_data\_factory\_integration\_runtime\_self\_hosted\_secondary\_authorization\_key) | The secondary integration runtime authentication key. |
| <a name="output_data_factory_name"></a> [data\_factory\_name](#output\_data\_factory\_name) | Azure Datafactory name |
| <a name="output_data_factory_principal_id"></a> [data\_factory\_principal\_id](#output\_data\_factory\_principal\_id) | Type of managed identity |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->