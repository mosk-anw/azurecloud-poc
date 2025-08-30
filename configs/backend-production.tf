# Backend configuration for production environment
# This file should be copied to backend.tf during deployment

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "tfstateprod123"
    container_name       = "tfstate"
    key                  = "prod/terraform.tfstate"
  }
}
