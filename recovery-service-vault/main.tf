resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-hub"
  location            = var.rg-location
  resource_group_name = var.rg-name
  sku                 = "Standard"

  soft_delete_enabled = true
}
