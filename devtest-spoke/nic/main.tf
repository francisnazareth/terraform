resource "azurerm_network_interface" "nic-linsvr1" {
  name                = "nic-linsvr1"
  location            = var.rg-location
  resource_group_name = var.rg-name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.app-subnet-id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "DevTest"
  }
}

#resource "azurerm_network_interface_security_group_association" "example" {
#  network_interface_id      = azurerm_network_interface.nic-linsvr1.id
#  network_security_group_id = var.nsg-id
#}
