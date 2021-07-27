resource "azurerm_log_analytics_workspace" "la-workspace-hub" {
  name                = "laworkspace-hub-001"
  location            = var.rg-location
  resource_group_name = var.rg-name
  sku                 = "PerGB2018"
  retention_in_days   = var.la-log-retention-in-days
}

resource "azurerm_log_analytics_solution" "la-hub-solution" {
  solution_name         = "ContainerInsights"
  location              = var.rg-location
  resource_group_name   = var.rg-name
  workspace_resource_id = azurerm_log_analytics_workspace.la-workspace-hub.id
  workspace_name        = azurerm_log_analytics_workspace.la-workspace-hub.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

