resource "azurerm_resource_group" "hub-rg" {
  name     = "rg-hub-${var.customer-name}-01"
  location = var.hub-location
  tags = {
    environment = "Hub"
  }
}

