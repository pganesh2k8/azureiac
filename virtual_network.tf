#VNET
resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet1234"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.2.0.0/16"]
  ddos_protection_plan {

    id     = azurerm_network_ddos_protection_plan.ddos.id
    enable = true
  }
  tags = {
    "Environment"   = "dev"
    "Deployed from" = "Azure DevOps"
  }
}
/*#Vnet Peering    
    resource "azurerm_virtual_network_peering" "peering-1" {
      name                      = "peer01"
      resource_group_name       = azurerm_resource_group.rg.name
      virtual_network_name      = azurerm_virtual_network.vnet01.name
      remote_virtual_network_id = "/subscriptions/c800b947-6b3a-4bc3-8aa0-1f4e9b562c82/resourceGroups/rg-network-sap-nonprod-uaen-001/providers/Microsoft.Network/virtualNetworks/vnet-sap-nonprod-uaen-001"
      allow_forwarded_traffic      = true
    }*/
#subnet
resource "azurerm_subnet" "frontend" {
  name                 = "frontendsnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.2.240.0/21"]
}
resource "azurerm_subnet" "backend" {
  name                 = "backendsnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.2.248.0/22"]
}
resource "azurerm_subnet" "firewallrg" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.2.254.0/23"]
}
resource "azurerm_subnet" "bastionrg" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.2.252.0/23"]
}
resource "azurerm_public_ip" "pubip" {
  name                = "pubip01"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  
}

resource "azurerm_public_ip" "bastpubip" {
  name                = "bastpubip01"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_public_ip" "firewallpubip" {
  name                = "firewallpubip01"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
#DDos protection
resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = "ddos-test123"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    Environment = "dev"
  }
  depends_on = [var.resource_group_name]
}
