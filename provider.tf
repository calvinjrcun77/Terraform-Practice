terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "1.38.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "0490d8dd-39e8-4fa9-80c3-898f049e3b6d"
  client_id       = "5e3ecc85-00bb-4c07-8e49-dc8fda2c8cd4"
  client_secret   = "JiO8Q~dfPlcwdVCI6jHjwyK_fNbm15umzADf8baP"
  tenant_id       = "6bd18ffc-7a23-4624-904f-045843b60843"
}