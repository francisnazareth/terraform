resource "azurerm_mssql_server" "sql-server" {
  name                         = var.sql-server-name
  resource_group_name          = var.rg-name
  location                     = var.rg-location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Passw0rd123"
}


resource "azurerm_sql_firewall_rule" "example" {
  name                = "fw-allow-app-subnet"
  resource_group_name = var.rg-name
  server_name         = azurerm_mssql_server.sql-server.name
  start_ip_address    = "10.20.0.192"
  end_ip_address      = "10.20.0.208"
}

resource "azurerm_mssql_database" "sample" {
  name           = "sample"
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
}
