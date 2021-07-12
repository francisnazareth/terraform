resource "azurerm_log_analytics_workspace" "la-ooredoo-hub" {
  name                = "la-ooredoo-hub-001"
  location            = var.hub-location
  resource_group_name = var.hub-vnet-resource-group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
