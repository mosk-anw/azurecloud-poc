provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "myResourceGroup"
  location = "uksouth"
}

resource "azurerm_kubernetes_cluster" "mycluster01" {
  name                = "mycluster01"
  location            = azurerm_resource_group.myresourcegroup.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  dns_prefix          = "mycluster01"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    zones      = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }
}