# Backend configuration for development environment
# This file should be copied to backend.tf during deployment

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "tfstatedeva7f2b9c8"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}
