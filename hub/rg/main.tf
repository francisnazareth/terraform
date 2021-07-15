resource "azurerm_resource_group" "hub-rg" {
  name     = var.hub-rg
  location = var.hub-location
  tags = {
    environment = "Hub"
  }
}

output "rg-name" {
   value  = azurerm_resource_group.hub-rg.name
}

output "rg-location" {
   value = azurerm_resource_group.hub-rg.location
}
