terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "tfstateproda7f2b9c8"
    container_name       = "tfstate"
    key                  = "production.terraform.tfstate"
  }
}
