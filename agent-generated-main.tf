```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-rg"
  location = "UK South"
}

output "resource_group_id" {
  value = azurerm_resource_group.test.id
}
```