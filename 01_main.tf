terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "268a434d-f7e6-4966-bb27-d29e20a1b360"
}