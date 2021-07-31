
resource "azurerm_application_insights" "nodejs_app_insight" {
  name                = "nodejs_app_insights"
  location            = "${var.rg-location}"
  resource_group_name = "${var.rg-name}"
  application_type    = "Node.JS"
}
