resource "azurerm_storage_account" "ooredoo-hub-storage" {
  name                     = "${var.customer-name}diagstor02"
  resource_group_name      = var.hub-rg
  location                 = var.hub-location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Hub"
  }
}
