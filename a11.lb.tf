/*resource "azurerm_public_ip" "web_lbpublicip" {
  name                = "${var.web_subnet_name}-web-linuxvm-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard"
  #domain_name_label = "app1-vm-${random_string.myrandom.id}"
}

###create the standard load balancer
resource "azurerm_lb" "web_lb" {
  name                = "${var.web_subnet_name}-web-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"
  frontend_ip_configuration {
    name = "web-lb-publicip"
    public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
  }
}

#create backend address pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
    name = "web-backedn"
    loadbalancer_id = azurerm_lb.web_lb.id
}

##3we need to do health checkup
resource "azurerm_lb_probe" "web_lb_probe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id 
}

#load balancer rule
resource "azurerm_lb_rule" "web_lb_rule_app1" {
  loadbalancer_id = azurerm_lb.web_lb.id 
  name = "web-app-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name 
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
  probe_id = azurerm_lb_probe.web_lb_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id = azurerm_network_interface.web_linuxvm_nic.id 
  ip_configuration_name = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
}*/