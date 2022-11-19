resource "azurerm_storage_account" "bucket" {
  name                     = "brobromackenzie"
  location                 = azurerm_resource_group.deck.location
  resource_group_name      = azurerm_resource_group.deck.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}
