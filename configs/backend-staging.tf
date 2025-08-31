# Backend configuration for staging environment
# This file should be copied to backend.tf during deployment

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-staging"
    storage_account_name = "tfstateprda7f2b9c8"
    container_name       = "tfstate"
    key                  = "staging/terraform.tfstate"
  }
}
