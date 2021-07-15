resource "random_id" "storage" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    storage_seed = "1234"
  }

  byte_length = 8
}


resource "azurerm_storage_account" "hub-storage" {
  name                     = "st${random_id.storage.hex}"
  resource_group_name      = var.rg-name
  location                 = var.rg-location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Hub"
  }
}
