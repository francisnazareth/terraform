resource "azurerm_log_analytics_workspace" "la-laworksplace-hub" {
  name                = "laworkspace-hub-001"
  location            = var.hub-location
  resource_group_name = var.hub-rg
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
