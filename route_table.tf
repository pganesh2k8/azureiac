#Route tables
resource "azurerm_route_table" "rt01" {
  name                          = "route_table01"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  disable_bgp_route_propagation = "false"
  tags = {
    "Environment"   = "dev"
    "Deployed from" = "Azure DevOps"
  }
}
/* route {
        name = var.route_name
        address_prefix = var.address_prefix
        next_hop_type = "VirtualAppliance"
        next_hop_in_ip_address = "10.2.128.110"
        }

    }*/
#Route table Association

resource "azurerm_subnet_route_table_association" "rtsubsc01" {
  subnet_id      = azurerm_subnet.frontend.id
  route_table_id = azurerm_route_table.rt01.id
}
