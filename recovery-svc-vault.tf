resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-hub"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group
  sku                 = "Standard"

  soft_delete_enabled = true
}
