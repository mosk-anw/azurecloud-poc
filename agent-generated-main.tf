```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "motest" {
  name     = "motest"
  location = "UK South"
}
```