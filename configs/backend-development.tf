# Backend configuration for development environment
# This file should be copied to backend.tf during deployment

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "tfstatedev123"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}
