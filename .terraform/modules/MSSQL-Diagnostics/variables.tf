# ---------------------------
# Diagnostics variables
# ---------------------------
variable "diag_config" {
  description = <<-EOF
    Parameters used to configure `Azure Diagnostics`
        `name` = (`Required` Specifies the name of the Diagnostic Setting. Changing this forces a new resource to be created.)

        `target_resource_id` = (`Required` The ID of an existing Resource on which to configure Diagnostic Settings.)

        `eventhub_name` = (`Optional` Specifies the name of the Event Hub where Diagnostics Data should be sent.)
  EOF
  type = map(object({
    name               = string
    target_resource_id = string
    eventhub_name      = optional(string)
  }))
}

variable "resource_id" {
  description = "The ID of an existing Resource which Monitor Diagnostics Categories should be retrieved for."
  type        = string
}

variable "log_category" {
  description = "The name of a Diagnostic Log Category for this Resource."
  type        = set(string)
  default     = []
}

variable "log_rp_days" {
  description = "The number of days for which this log Retention Policy should apply."
  type        = number
  default     = 0
}

variable "metric_rp_days" {
  description = "The number of days for which this metric Retention Policy should apply."
  type        = number
  default     = 0
}

variable "log_analytics_destination_type" {
  description = "When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  type        = string
  default     = "Dedicated"
}

variable "logs_destinations_ids" {
  description = "Log destination ID. At least one of eventhub_authorization_rule_id, log_analytics_workspace_id, partner_solution_id and storage_account_id must be specified."
  type        = list(string)
}
