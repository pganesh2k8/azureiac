# Bastion
resource "azurerm_bastion_host" "bstion01" {
  name                = "bastion-test"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionrg.id
    public_ip_address_id = azurerm_public_ip.bastpubip.id
  }
}