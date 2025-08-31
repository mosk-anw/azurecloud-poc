terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "tfstatestaging123"
    container_name       = "tfstate"
    key                  = "production.terraform.tfstate"
  }
}
