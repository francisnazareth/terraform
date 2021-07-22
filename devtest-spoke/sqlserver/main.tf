resource "azurerm_mssql_server" "sql-server" {
  name                         = "qr-sqlserver-3234"
  resource_group_name          = var.rg-name
  location                     = var.rg-location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Passw0rd!123"
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
