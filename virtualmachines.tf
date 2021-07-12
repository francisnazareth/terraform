resource "azurerm_network_interface" "nic-jumpbox-1" {
  name                = "nic-jumpbox-1"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub-mgmt-subnet-001.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm-jumpbox-1" {
  name                = "linux-jump-server-1"
  resource_group_name = var.hub-vnet-resource-group
  location            = var.hub-location
  size                = "Standard_D2a_v4"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-jumpbox-1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "nic-jumpbox-2" {
  name                = "nic-jumpbox-2"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub-mgmt-subnet-002.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-jumpbox-2" {
  name                = "winjumpserver1"
  resource_group_name = var.hub-vnet-resource-group 
  location            = var.hub-location
  size                = "Standard_D2a_v4"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic-jumpbox-2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
