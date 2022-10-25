#KeyVault

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = "mydsdfvault-1423"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "Purge",
      "Recover"
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

# key vault key
resource "azurerm_key_vault_key" "keyvault_key" {
  name         = "mykey"
  key_vault_id = azurerm_key_vault.keyvault.id
  key_type     = "RSA"
  key_size     = 2048

  /*  depends_on = [
    azurerm_key_vault_access_policy.KeyVault-user
  ]
*/
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}