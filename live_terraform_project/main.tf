terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.46"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "example_rg" {
  name     = "testrg01"
  location = "UK South"
  tags = {
    env = "test"
  }
}
