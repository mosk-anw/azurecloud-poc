```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "new_rg" {
  name     = "new-rg"
  location = "South India"
}

resource "azurerm_kubernetes_cluster" "aks_test01" {
  name                = "aks-test01"
  location            = azurerm_resource_group.new_rg.location
  resource_group_name = azurerm_resource_group.new_rg.name
  dns_prefix          = "aks-test01-dns"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.22.4" # Example version, replace with the actual stable version if necessary

  lifecycle {
    ignore_changes = [kubernetes_version]
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_test01.kube_config_raw
}
```