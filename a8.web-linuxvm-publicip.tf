resource "random_string" "myrandom" {
  length = 5
  upper = false 
  special = false
  numeric = false
}
resource "azurerm_public_ip" "example" {
  name                = "${var.web_subnet_name}-web-linuxvm-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard"
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
}