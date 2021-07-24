output "sql-server-name" {
   value = azurerm_mssql_server.sql-server.name
}

output "sql-user" {
   value = azurerm_mssql_server.sql-server.administrator_login
}

output "sql-password" { 
   value = azurerm_mssql_server.sql-server.administrator_login_password
}

