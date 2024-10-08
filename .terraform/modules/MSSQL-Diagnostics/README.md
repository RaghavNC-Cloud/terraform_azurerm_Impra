## Azure Diagnostic Settings

The module allows you to configure streaming export of platform logs and metrics for a resource to the destination of your choice (eventhub, log analytical workspace, storage account). For more info, click [here](https://registry.terraform.io/providers/hashicorp/azurerm/3.51.0/docs/resources/monitor_diagnostic_setting)

## Usage

```
locals {
  diag_config = {
    # Azure Datafactory Diagnostics
    0 = {
      name               = var.name
      target_resource_id = var.target_resource_id
      eventhub_name      = var.eventhub_name
    }
  }
}

module "Datafactory-Diagnostics" {
  source                = "app.terraform.io/<TFC Organisation>/diagnostics/azurerm"
  version               = "x.x.x"
  diag_config           = local.diag_config
  resource_id           = var.resource_id
  logs_destinations_ids = [var.logs_destinations_ids]
  log_category          = var.log_category
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->