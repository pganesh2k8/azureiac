# NIC for windows
resource "azurerm_network_interface" "nic01" {
  name                = "winnic01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "winnic_ipconfig01"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    #enable_accelerated_networking = true
  }
  tags = {
    "Environment"   = "dev"
    "Deployed from" = "Azure DevOps"

  }
}

#Network_Interface_Card_linux
resource "azurerm_network_interface" "nic02" {

  name                = "linxnic01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #enable_accelerated_networking = true


  ip_configuration {
    name                          = "linxnic_ipconfig01"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    "Environment"   = "dev"
    "Deployed from" = "Azure DevOps"

  }

}