resource "azurerm_firewall" "firewallrg" {
  name                = "testfirewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewallrg.id
    public_ip_address_id = azurerm_public_ip.firewallpubip.id
  }
}