terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

# Create Resource Group using AVM
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"

  name     = "rg-dev12345"
  location = "uksouth"
}
