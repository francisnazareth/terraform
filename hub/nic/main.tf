resource "azurerm_network_interface" "nic-linjumpsvr1" {
  name                = "nic-linux-jumpsvr1"
  location            = var.rg-location
  resource_group_name = var.rg-name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.mgmt-snet-1-id 
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Hub"
  }
}

resource "azurerm_network_interface_security_group_association" "lin-nic-to-nsg" {
  network_interface_id      = azurerm_network_interface.nic-linjumpsvr1.id
  network_security_group_id = var.nsg-id
}

resource "azurerm_network_interface" "nic-winjumpsvr1" {
  name                = "nic-windows-jumpsvr1"
  location            = var.rg-location
  resource_group_name = var.rg-name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.mgmt-snet-2-id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Hub"
  }
}

resource "azurerm_network_interface_security_group_association" "win-nic-to-nsg" {
  network_interface_id      = azurerm_network_interface.nic-winjumpsvr1.id
  network_security_group_id = var.nsg-id
}

