resource "azurerm_network_security_group" "nsg_devtest_01" {
  name                = "nsg-devtest-01"
  location            = var.rg-location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "allow-inbound-8080"
    priority                   = 100
    direction                  = "InBound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}
