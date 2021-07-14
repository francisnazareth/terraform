resource "azurerm_network_interface" "nic-linjumpserver1" {
  name                = "nic-linjumpserver1"
  location            = var.hub-location
  resource_group_name = var.hub-rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub-mgmt-subnet-001.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm-jumpbox-1" {
  name                = "linjumpserver1"
  resource_group_name = var.hub-rg
  location            = var.hub-location
  size                = "Standard_D2a_v4"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-linjumpserver1.id,
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

resource "azurerm_virtual_machine_extension" "da" {
  name                       = "DAExtension"
  virtual_machine_id         =  azurerm_linux_virtual_machine.vm-jumpbox-1.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true

}

resource "azurerm_network_interface" "nic-winjumpserver1" {
  name                = "nic-winjumpserver1"
  location            = var.hub-location
  resource_group_name = var.hub-rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub-mgmt-subnet-002.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-jumpbox-2" {
  name                = "winjumpserver1"
  resource_group_name = var.hub-rg
  location            = var.hub-location
  size                = "Standard_D2a_v4"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic-winjumpserver1.id,
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
