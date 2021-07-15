resource "azurerm_network_interface" "nic-linsvr1" {
  name                = "nic-linsvr1"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.app-subnet-id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm-linsvr1" {
  name                = "linserver1"
  resource_group_name = var.rg-name
  location            = var.rg-location
  size                = "Standard_D2a_v4"
  admin_username      = "linadmin"
  admin_password      = "Passw0rd123!"
  disable_password_authentication  = "false"
  provision_vm_agent  = true
  network_interface_ids = [
    azurerm_network_interface.nic-linsvr1.id,
  ]

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

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "voting-web-sample"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linsvr1.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings= <<SETTINGS
   {
      "fileUris": ["https://raw.githubusercontent.com/francisnazareth/mslearn-n-tier-architecture/master/Deployment/setup-votingweb.sh",
                   "https://raw.githubusercontent.com/francisnazareth/mslearn-n-tier-architecture/master/Deployment/votingweb.conf",
                   "https://raw.githubusercontent.com/francisnazareth/mslearn-n-tier-architecture/master/Deployment/votingweb.service",
                   "https://raw.githubusercontent.com/francisnazareth/mslearn-n-tier-architecture/master/Deployment/votingweb.zip"
                  ]
   }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
           "commandToExecute": "sh setup-votingweb.sh"
    }

  PROTECTED_SETTINGS

  tags = {
    environment = "Production"
  }
}
