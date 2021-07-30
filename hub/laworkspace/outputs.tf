
output "la-workspace-id" {
   value = azurerm_log_analytics_workspace.la-workspace-hub.workspace_id
}

output "la-workspace-key" { 
  value = azurerm_log_analytics_workspace.la-workspace-hub.primary_shared_key
}

