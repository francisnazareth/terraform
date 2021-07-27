resource "azurerm_subnet_route_table_association" "app-subnet-to-route-table" {
  subnet_id      = var.app-subnet-id
  route_table_id = var.route-table-id
}
