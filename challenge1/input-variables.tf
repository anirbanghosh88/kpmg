variable "webtier_rg" {
  type = string
  default = "webrg"
}
variable "apptier_rg" {
  type = string
  default = "apprg"
}
variable "dbtier_rg" {
  type = string
  default = "dbrg"
}
variable "network_rg" {
  type = string
  default = "netrg"
}
variable "location" {
    type = string
    default = "eastus2"  
}
variable "subscription_id" {
    type = string
}
variable "client_id" {
    type = string
}
variable "client_secret" {
    type = string  
}
variable "tenant_id" {
    type = string  
}


locals {
  default_tags = {
    environment = "dev",
    location = var.location
  }
}