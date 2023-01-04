output "web_linuxvm_private_ip_address" {
  description = "web linux vm private ip"
  value = azurerm_linux_virtual_machine.example.private_ip_address
}