resource "azurerm_resource_group" "hub-rg" {
  name     = "rg-${var.customer-name}-hub-01"
  location = var.hub-location
  tags = {
    environment = "Hub"
  }
}

