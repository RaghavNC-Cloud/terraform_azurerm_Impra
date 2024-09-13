output "sql_server_id" {
  description = "The unique identifier(s) of the Azure SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.id }
}

output "sql_server_name" {
  description = "The name(s) of the Azure SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.name }
}

output "sql_server_resource_group_name" {
  description = "The name of the Azure resource group in which the SQL Server(s) is located."
  value       = { for v in azurerm_mssql_server.this : v.name => v.resource_group_name }
}

output "sql_server_administrator_login" {
  description = "The administrator login(s) for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.administrator_login }
}

output "sql_server_administrator_login_password" {
  description = "The administrator login password(s) for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.administrator_login_password }
  sensitive   = true
}

output "sql_server_azuread_administrator" {
  description = "The Azure AD administrator(s) for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.azuread_administrator }
}

output "sql_server_fully_qualified_domain_name" {
  description = "The fully qualified domain name(s) for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.fully_qualified_domain_name }
}

output "sql_server_identity" {
  description = "The identity configuration for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.identity }
}

output "sql_server_identity_principal_id" {
  description = "The principal ID(s) associated with the identity of the SQL Server(s)."
  value = {
    for k, v in azurerm_mssql_server.this : k => join(",", v.identity.*.principal_id)
  }
}

output "sql_server_primary_user_assigned_identity_id" {
  description = "The ID(s) of the primary user assigned identity(ies) for the SQL Server(s)."
  value       = { for v in azurerm_mssql_server.this : v.name => v.primary_user_assigned_identity_id }
}

output "sql_database_id" {
  description = "The unique identifier(s) of the Azure SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.id }
}

output "sql_database_name" {
  description = "The name(s) of the Azure SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.name }
}

output "sql_database_server_id" {
  description = "The ID(s) of the Azure SQL Server associated with the SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.server_id }
}

output "sql_database_creation_source_database_id" {
  description = "The ID(s) of the source database(s) used for creation of the Azure SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.creation_source_database_id }
}

output "sql_database_recover_database_id" {
  description = "The ID(s) of the recoverable database(s) for the Azure SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.recover_database_id }
}

output "sql_database_restore_dropped_database_id" {
  description = "The ID(s) of the restore-dropped database(s) for the Azure SQL Database(s)."
  value       = { for v in azurerm_mssql_database.this : v.name => v.restore_dropped_database_id }
}

output "sql_admin_password" {
  description = "SQL Admin password"
  value       = { for v in azurerm_mssql_server.this : v.name => v.administrator_login_password }
}
