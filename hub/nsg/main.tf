resource "azurerm_network_security_group" "nsg_hub_01" {
  name                = "nsg-hub-01"
  location            = var.rg-location
  resource_group_name = var.rg-name

  tags = {
    environment = "Hub"
  }
}
