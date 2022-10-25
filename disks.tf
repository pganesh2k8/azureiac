resource "azurerm_managed_disk" "mgddisk01" {

  name                 = "mgd_disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "512"
  tags = {
    "Environment"   = "dev"
    "Application"   = "SAP Web Dispacher"
    "Deployed from" = "Azure DevOps"
  }

}
resource "azurerm_virtual_machine_data_disk_attachment" "vmdisk_att01" {

  managed_disk_id    = azurerm_managed_disk.mgddisk01.id
  virtual_machine_id = azurerm_linux_virtual_machine.linxvm01.id
  lun                = "1"
  caching            = "ReadWrite"
  #write_accelerator_enabled = "true"
  depends_on = [azurerm_linux_virtual_machine.linxvm01, azurerm_managed_disk.mgddisk01]
}

  