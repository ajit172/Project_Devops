output "public_ip_ids" {
  value = { for pip in azurerm_public_ip.pip : pip.name => pip.id }
}