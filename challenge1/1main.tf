## Deploy a 3 tier application 
terraform {
  required_version = "~> 1.3.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstateac1"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

