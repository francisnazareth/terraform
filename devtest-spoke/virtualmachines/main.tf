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

#===================================================================
#Dependency Agent
#===================================================================

resource "azurerm_virtual_machine_extension" "da" {
  name                       = "DAExtension"
  virtual_machine_id         =  azurerm_linux_virtual_machine.vm-linsvr1.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId" : "${var.la-workspace-id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey" : "${var.la-workspace-key}"
    }
  PROTECTED_SETTINGS
}

#===================================================================
# Set Monitoring and Log Analytics Workspace
#===================================================================
resource "azurerm_virtual_machine_extension" "oms_mma02" {
  name                       = "test-OMSExtension"
 virtual_machine_id         =  azurerm_linux_virtual_machine.vm-linsvr1.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.12"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId" : "${var.la-workspace-id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey" : "${var.la-workspace-key}"
    }
  PROTECTED_SETTINGS
}

#===================================================================
# Custom script extension to install Votes Nodejs application
#===================================================================

resource "azurerm_virtual_machine_extension" "fn-nodejs-extn" {
  name                 = "nodejs-sample"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linsvr1.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings= <<SETTINGS
   {
      "fileUris": ["https://raw.githubusercontent.com/francisnazareth/azure-nodejs/main/setupnodesvr.sh", 
                   "https://github.com/francisnazareth/azure-nodejs/raw/main/vote.tgz"
                  ]
   }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
           "commandToExecute": "sh setupnodesvr.sh ${var.sql-server-name}.privatelink.database.windows.net ${var.sql-user} ${var.sql-password} ${var.instrumentation-key}"
    }

  PROTECTED_SETTINGS

  tags = {
    environment = "DevTest"
  }
}

