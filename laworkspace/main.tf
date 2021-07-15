resource "azurerm_log_analytics_workspace" "la-workspace-hub" {
  name                = "laworkspace-hub-001"
  location            = var.rg-location
  resource_group_name = var.rg-name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
