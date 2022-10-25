#NSG
resource "azurerm_network_security_group" "nsg01" {
  name                = "mynsg01"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    "Environment"   = "dev"
    "Deployed from" = "Azure DevOps"
  }
}
#NSG Association

resource "azurerm_subnet_network_security_group_association" "nsgas01" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
  depends_on                = [azurerm_network_security_group.nsg01]
}
