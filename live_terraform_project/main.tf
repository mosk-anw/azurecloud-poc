terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.46"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "new_rg" {
  name     = "test-devops-agent-rg5566"
  location = "UK South"
}