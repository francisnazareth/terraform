resource "azurerm_resource_group" "devtest-rg" {
  name     = var.devtest-rg-name
  location = var.devtest-rg-location

  tags = {
    environment = "DevTest"
  }
}

output "rg-name" {
   value  = azurerm_resource_group.devtest-rg.name
}

output "rg-location" {
   value = azurerm_resource_group.devtest-rg.location
}
