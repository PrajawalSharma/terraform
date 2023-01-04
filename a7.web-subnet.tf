##3we will create subnet
resource "azurerm_subnet" "websubnet" {
  name                 = "${local.resource_name_prefix}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}

##we will create an nsg --nsg need to be attached with your subnet
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${var.web_subnet_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#the top level nsg we will assoicate with subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
    depends_on = [
      azurerm_network_security_rule.web_nsg_rule_inbound
    ]
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
locals {
  web_inbound_port = {
  "110":"80",
  "120":"443",
  "130": "2222"
  }
  ##in terraform if your key start with a numeric  then the difference between key and value need to put :
}
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_port
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}
