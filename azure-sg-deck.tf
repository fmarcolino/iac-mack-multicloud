resource "azurerm_network_security_group" "deck" {
  name                = "nsg-deck"
  location            = azurerm_resource_group.deck.location
  resource_group_name = azurerm_resource_group.deck.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DECK"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4440"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.tags
}
