resource "azurerm_public_ip" "weblbpubip" {
  name                = "weblbpubip"
  location            = azurerm_resource_group.webrg.location
  resource_group_name = azurerm_resource_group.webrg.name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "weblb" {
  name                = "weblb"
  location            = azurerm_resource_group.webrg.location
  resource_group_name = azurerm_resource_group.webrg.name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = "webfePubip"
    public_ip_address_id = azurerm_public_ip.weblbpubip.id
  }
}

resource "azurerm_lb_backend_address_pool" "weblbbep" {
  loadbalancer_id = azurerm_lb.weblb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_rule" "weblbrule" {
  loadbalancer_id                = azurerm_lb.weblb.id
  name                           = "rule1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "webfePubip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.weblbbep.id]
}

resource "azurerm_lb_probe" "weblbprobe" {
  loadbalancer_id = azurerm_lb.weblb.id
  name            = "hhtp-running-probe"
  port            = 80
}