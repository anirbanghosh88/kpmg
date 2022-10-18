output "weblbip" {
    value = azurerm_public_ip.weblbpubip.ip_address
}
output "applbip" {
    value = azurerm_lb.applb.private_ip_address
}  