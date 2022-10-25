# Automation account
resource "azurerm_automation_account" "autoacrg" {
  name                = "autoacc01"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"

  tags = {
    environment = "development"
  }
}