data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "hub-keyvault" {
  name                        = "kv-${var.customer-name}-hub-08"
  location                    = var.rg-location
  resource_group_name         = var.rg-name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft-delete-retention-days
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
