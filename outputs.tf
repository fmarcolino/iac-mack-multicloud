output "azure_deck_ip" {
  description = "Server 1 RunDeck Public IP (Azure Cloud)"

  value = azurerm_linux_virtual_machine.deck.public_ip_address
}

output "aws_php_ip" {
  description = "Server 2 Php Server Public IP (AWS Cloud)"

  value = module.php_server.public_ip
}

output "aws_jenkins_ip" {
  description = "Server 3 Jenkins Server Public IP (AWS Cloud)"

  value = module.jenkins_server.public_ip
}

output "tls_private_key" {
  description = "Private key for instance access (all instances)"
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
