#Windows VM
resource "azurerm_windows_virtual_machine" "winvm01" {
  name                  = "winvm01"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_E4s_v3"
  admin_username        = "Winadmin"
  admin_password        = "Password@123"
  network_interface_ids = [azurerm_network_interface.nic01.id]


  /*source_image_id = "/subscriptions/c800b947-6b3a-4bc3-8aa0-1f4e9b562c82/resourceGroups/rg-storage-prod-uaen-001/providers/Microsoft.Compute/galleries/acg_eosapproduae001/images/Windows2019STD/versions/0.0.2"
        license_type = "Windows_Server"
        
        boot_diagnostics  {
            storage_account_uri = "https://saeosapdiaghubuaen001.blob.core.windows.net/"
        }*/

  os_disk {
    name                 = "vmjumphub01-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "128"

  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

#Linux VM 
resource "azurerm_linux_virtual_machine" "linxvm01" {

  name                            = "linxvm01"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic02.id]

  size           = "Standard_D4s_v3"
  admin_username = "linuxadmin"
  admin_password = "Password@123"


  /* boot_diagnostics  {
            storage_account_uri = "https://saeosapdiaghubuaen001.blob.core.windows.net/"
        }

            tags = {
            "Environment" = var.environment
            "Application" = "SAP Web Dispacher"
            "Deployed from" = "Azure DevOps"
            }
        #license_type                 = "SLES_BYOS"

        #source_image_id = "/subscriptions/c800b947-6b3a-4bc3-8aa0-1f4e9b562c82/resourceGroups/rg-storage-prod-uaen-001/providers/Microsoft.Compute/galleries/acg_eosapproduae001/images/SLES12SP5_byol/versions/0.0.3"
        */
  os_disk {
    name                 = "sapwdpprd-osdisk"
    disk_size_gb         = "64"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_disk_encryption_set" "diskencry01" {
  name                = "disk_encryption01"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.keyvault_key.id

  identity {
    type = "SystemAssigned"
  }
}