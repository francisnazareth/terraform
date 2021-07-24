resource "azurerm_mssql_server" "sql-server" {
  name                         = var.sql-server-name
  resource_group_name          = var.rg-name
  location                     = var.rg-location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Passw0rd123"
}

resource "azurerm_sql_firewall_rule" "rule-allow-app-subnet" {
  name                = "fw-allow-app-subnet"
  resource_group_name = var.rg-name
  server_name         = azurerm_mssql_server.sql-server.name
  start_ip_address    = var.app-subnet-start-ip 
  end_ip_address      = var.app-subnet-end-ip  
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

resource "azurerm_private_dns_zone" "db-private-dns-zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db-private-vnet-link" {
  name                  = "test"
  resource_group_name   = var.rg-name
  private_dns_zone_name = azurerm_private_dns_zone.db-private-dns-zone.name
  virtual_network_id    = var.vnet-id
}

resource "azurerm_private_endpoint" "sqlserver-pe" {
  name                = "pe-sqlserver"
  location            = var.rg-location
  resource_group_name = var.rg-name
  subnet_id           = var.db-subnet-id

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.db-private-dns-zone.id]
  }

  private_service_connection {
    name                           = "sqlsvr-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.sql-server.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }
}
