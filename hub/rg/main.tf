resource "azurerm_resource_group" "hub-rg" {
  name     = var.hub-rg
  location = var.hub-location
  tags = {
    environment = "Hub"
  }
}

