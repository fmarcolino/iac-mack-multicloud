resource "azurerm_network_interface" "deck" {
  name                = "deck-nic"
  location            = azurerm_resource_group.deck.location
  resource_group_name = azurerm_resource_group.deck.name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.deck.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.deck.id
  }

  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.deck.id
  network_security_group_id = azurerm_network_security_group.deck.id
}

resource "azurerm_linux_virtual_machine" "deck" {
  name                = "deck-machine"
  resource_group_name = azurerm_resource_group.deck.name
  location            = azurerm_resource_group.deck.location
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.deck.id,
  ]

  custom_data = filebase64("${path.module}/user-datas/rundeck-server.sh")

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.this.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9"
    version   = "latest"
  }

  tags = local.tags
}
