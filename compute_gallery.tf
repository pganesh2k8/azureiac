# Azure compute gallery
resource "azurerm_shared_image_gallery" "gallertrg" {
  name                = "gallertrg_image_gallery"
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Shared images and things."

  tags = {
    Hello = "There"
    World = "gallertrg"
  }
}

resource "azurerm_shared_image" "gallertrg" {
  name                = "my-image"
  gallery_name        = azurerm_shared_image_gallery.gallertrg.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"

  identifier {
    publisher = "PublisherName"
    offer     = "OfferName"
    sku       = "gallertrgSku"
  }
}
