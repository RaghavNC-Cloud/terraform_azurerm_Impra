locals {
  # Split the destinations from the variable and grab the first element from the list
  # Set the log analytics destination type only if log needs to be sent to log analytics workspace
  storage_account_id             = coalescelist([for r in var.logs_destinations_ids : r if contains(split("/", lower(r)), "microsoft.storage")], [null])[0]
  eventhub_authorization_rule_id = coalescelist([for r in var.logs_destinations_ids : r if contains(split("/", lower(r)), "microsoft.eventhub")], [null])[0]
  log_analytics_workspace_id     = coalescelist([for r in var.logs_destinations_ids : r if contains(split("/", lower(r)), "microsoft.operationalinsights")], [null])[0]
  log_analytics_destination_type = local.log_analytics_workspace_id != null ? var.log_analytics_destination_type : null
}
