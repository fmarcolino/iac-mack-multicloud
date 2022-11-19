resource "azurerm_virtual_network" "deck" {
  name                = "vnet-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.deck.location
  resource_group_name = azurerm_resource_group.deck.name

  tags = local.tags
}

resource "azurerm_subnet" "deck" {
  name                 = "snet-private"
  resource_group_name  = azurerm_resource_group.deck.name
  virtual_network_name = azurerm_virtual_network.deck.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_resource_group.deck,
    azurerm_virtual_network.deck,
  ]
}

resource "azurerm_public_ip" "deck" {
  name                = "deckPublicIP"
  location            = azurerm_resource_group.deck.location
  resource_group_name = azurerm_resource_group.deck.name
  allocation_method   = "Dynamic"

  tags = local.tags
}
