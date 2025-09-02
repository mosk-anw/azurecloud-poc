terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "sttfstatedev"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
  }
}