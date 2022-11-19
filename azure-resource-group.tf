resource "azurerm_resource_group" "deck" {
  name     = "deck"
  location = local.azure_region

  tags = local.tags
}
