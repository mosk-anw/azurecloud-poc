```hcl
provider "azurerm" {
  features {}

  subscription_id = "<your-subscription-id>"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "India South"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "myfirstaks"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "aksdns"

  default_node_pool {
    name       = "agentpool"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    mode       = "User"
  }

  sku_tier = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}
```

Replace `<your-subscription-id>` with your actual Azure subscription ID. This code creates a new Azure Kubernetes Service (AKS) cluster with 2 nodes in the 'India South' region using Terraform. Make sure to have the Azure CLI set up and authenticated before applying this Terraform configuration.