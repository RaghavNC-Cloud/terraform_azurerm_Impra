# Output
output "diagnostic_settings_id" {
  description = "ID of the Diagnostic Settings."
  value       = { for v in azurerm_monitor_diagnostic_setting.this : v.name => v.id }
}
