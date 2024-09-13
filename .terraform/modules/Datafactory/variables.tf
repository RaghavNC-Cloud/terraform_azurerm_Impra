variable "adf_config" {
  description = <<-EOF
  Parameters used to configure `Azure Data Factory`

    `name` - (`Required` Specifies the name of the Data Factory.)

    `location` - (`Optional` Specifies the supported Azure location where the resource exists. `required`, defaults to `uksouth`)

    `resource_group_name` - (`Required` The name of the resource group in which to create the Data Factory.)

    `managed_virtual_network_enabled` - (`Optional` Is Managed Virtual Network enabled? `optional`, defaults to `true`)

    `public_network_enabled` - (`Optional` Is the Data Factory visible to the public network? `optional`, defaults to `false`)

    `github_configuration` - (`Optional` Github block defined below)

    `account_name` - (`Required` Specifies the GitHub account name.)

    `git_url` - (`Required` Specifies the GitHub Enterprise host name.)

    `repository_name` - (`Required` Specifies the name of the git repository.)

    `root_folder` - (`Required` Specifies the root folder within the repository.)

    `vsts_configuration` - (`Optional` VSTS configuration block defined below)

    `branch_name` - (`Required` Specifies the branch of the repository to get code from.)

    `account_name` - (`Required` Specifies the VSTS account name.)

    `branch_name - (`Required` Specifies the branch of the repository to get code from.)

    `project_name` - (`Required` Specifies the name of the VSTS project.)

    `repository_name` - (`Required` Specifies the name of the git repository.)

    `root_folder` - (`Required` Specifies the root folder within the repository.)

    `tenant_id` - (`Required` Specifies the Tenant ID associated with the VSTS account.)
  EOF
  type = map(object({
    name                            = string
    location                        = optional(string, "uksouth")
    resource_group_name             = string
    managed_virtual_network_enabled = optional(bool)
    public_network_enabled          = optional(bool)
    github_configuration = optional(object({
      account_name    = string
      branch_name     = string
      git_url         = string
      repository_name = string
      root_folder     = string
    }))
    vsts_configuration = optional(object({
      account_name    = string
      branch_name     = string
      project_name    = string
      repository_name = string
      root_folder     = string
      tenant_id       = string
    }))
  }))
  default = {}
}

variable "adf_pe_config" {
  description = <<-EOL
  Parameters used to configure `datafactory managed private endpoints`

    `name` - (`Required` Specifies the name which should be used for this Managed Private Endpoint. Changing this forces a new resource to be created.)

    `data_factory_name` - (`Required` Name of the datafactory.)

    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists.)

    `target_resource_id` - (`Required` The ID of the Private Link Enabled Remote Resource which this Data Factory Private Endpoint should be connected to. Changing this forces a new resource to be created.)

    `subresource_name` - (`Optional` Specifies the sub resource name which the Data Factory Private Endpoint is able to connect to. Changing this forces a new resource to be created.)

    `fqdns` - (`Optional` Fully qualified domain names. Changing this forces a new resource to be created.)
  EOL
  type = map(object({
    name                        = string
    data_factory_name           = string
    data_factory_resource_group = string
    target_resource_id          = string
    subresource_name            = optional(string)
    fqdns                       = optional(list(string))
  }))
  default = {}
}

variable "integration_runtime_configuration_azure_ssis" {
  description = <<EOF
  Parameters used to configure `AzureSSIS` integration runtime:

    `data_factory_name` - (`Required` Name of the datafactory.)

    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists.)

    `name` - (`Required` Specifies the name of the Azure-SSIS Integration Runtime.)

    `location` - (`Required` Specifies the supported Azure location where the resource exists.)

    `description` - (`Optional` Integration runtime description.)

    `node_size` - (`Required` The size of the nodes on which the Azure-SSIS Integration Runtime runs.)

    `number_of_nodes` - (`Optional` Number of nodes for the Azure-SSIS Integration Runtime. Defaults to `1`)

    `max_parallel_executions_per_nodes` - (`Optional` Defines the maximum parallel executions per node. Defaults to `1`)

    `edition` - (`Optional` The Azure-SSIS Integration Runtime edition. Defaults to `Standard`)

    `license_type` - (`Optional` The type of the license that is used. Defaults to `LicenseIncluded`)
  EOF
  type = map(object({
    data_factory_name                = string
    data_factory_resource_group      = string
    name                             = string
    location                         = string
    description                      = optional(string)
    node_size                        = string
    number_of_nodes                  = optional(number)
    max_parallel_executions_per_node = optional(number)
    edition                          = optional(string)
    license_type                     = optional(string)
  }))
  default = {}
}

variable "integration_runtime_configuration_azure" {
  description = <<EOF
  Parameters used to configure `Azure` integration runtime
    `data_factory_name` - (`Required` Name of the datafactory)

    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists)

    `name` - (`Required` Specifies the name of the Managed Integration Runtime.)

    `location` - (`Required` Specifies the supported Azure location where the resource exists.)

    `description` - (`Optional` Integration runtime description.)

    `cleanup_enabled` (`Optional` Cluster will not be recycled and it will be used in next data flow activity run until TTL (time to live) is reached if this is set as false. Defaults to `true`)

    `compute_type` (`Optional` Compute type of the cluster which will execute data flow job. Defaults to `General`)

    `core_count` (`Optional` Core count of the cluster which will execute data flow job. Defaults to `8`)

    `time_to_live_min` (`Optional` Time to live (in minutes) setting of the cluster which will execute data flow job. Defaults to `0`)

    `virtual_network_enabled` (`Optional` Is Integration Runtime compute provisioned within Managed Virtual Network? Defaults to `false`)
  EOF
  type = map(object({
    data_factory_name           = string
    data_factory_resource_group = string
    name                        = string
    location                    = string
    description                 = optional(string)
    cleanup_enabled             = optional(bool)
    compute_type                = optional(string)
    core_count                  = optional(number)
    time_to_live_min            = optional(number)
    virtual_network_enabled     = optional(bool)
  }))
  default = null
}

variable "integration_runtime_configuration_azure_self_hosted" {
  description = <<EOF
  Parameters used to configure `Azure` integration runtime
    `data_factory_name` - (`Required` Name of the datafactory)

    `data_factory_resource_group` - (`Required` The resource group in which the datafactory exists)

    `name` - (`Required` Specifies the name of the Managed Integration Runtime.)

    `description` - (`Optional` Integration runtime description.)
  EOF
  type        = list(map(string))
  default     = null
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
  default     = null
}

variable "tags" {
  type = map(string)
}
