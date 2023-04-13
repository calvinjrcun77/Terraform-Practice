terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "1.38.0"
    }
  }
}

provider "azurerm" {
  subscription_id = 
  client_id       = 
  client_secret   = 
  tenant_id       = 
}
