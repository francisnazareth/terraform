resource "azurerm_linux_virtual_machine" "vm-linsvr1" {
  name                = "linserver1"
  resource_group_name = var.rg-name
  location            = var.rg-location
  size                = "Standard_D2a_v4"
  admin_username      = var.linux-vm-admin-user
  admin_password      = var.linux-vm-admin-password
  disable_password_authentication  = "false"
  provision_vm_agent  = true
  network_interface_ids = [
    var.nic-linsvr1-id,
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

  tags = {
    environment = "DevTest"
  }
}

resource "azurerm_virtual_machine_extension" "fn-nodejs-extn" {
  name                 = "nodejs-sample"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linsvr1.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings= <<SETTINGS
   {
      "fileUris": ["https://raw.githubusercontent.com/francisnazareth/azure-nodejs/main/setupnodesvr.sh", 
                   "https://github.com/francisnazareth/azure-nodejs/raw/main/vote.tar"
                  ]
   }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
           "commandToExecute": "sh setupnodesvr.sh ${var.sql-server-name}.privatelink.database.windows.net ${var.sql-user} ${var.sql-password}"
    }

  PROTECTED_SETTINGS

  tags = {
    environment = "DevTest"
  }
}
