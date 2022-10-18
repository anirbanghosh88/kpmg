resource "azurerm_resource_group" "netrg" {
    name = var.network_rg
    location = var.location
  }
resource "azurerm_resource_group" "webrg" {
    name = var.webtier_rg
    location = var.location
}
resource "azurerm_resource_group" "apprg" {
    name = var.apptier_rg
    location = var.location  
}
resource "azurerm_resource_group" "dbrg" {
    name = var.dbtier_rg
    location = var.location 
}