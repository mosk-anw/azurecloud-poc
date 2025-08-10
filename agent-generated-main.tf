```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  type        = string
}

variable "password" {
  description = "Service Principal password"
  type        = string
}

variable "location" {
  description = "Azure Region in which all resources in this example should be provisioned"
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.prefix}-aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aci_subnet" {
  name                 = "${var.prefix}-aci-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/16"]

  delegation {
    name = "acidelegation"

    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
    }
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  = "1.19.11"
  dns_prefix          = "${var.prefix}aksdns"

  default_node_pool {
    name       = "agentpool"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "Standard"
  }

  addon_profile {
    aci_connector_linux {
      enabled     = true
      subnet_name = azurerm_subnet.aci_subnet.name
    }

    oms_agent {
      enabled = false
    }
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Development"
  }
}

output "kube_config" {
  description = "Kubectl configuration to access the cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "kube_admin_config" {
  description = "Admin Kubectl configuration to access the cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}
```