terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "tfstatedeva7f2b9c8"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
  }
}