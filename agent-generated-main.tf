terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "myaks01" {
  name                = "myaks01"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    min_count  = 1
    max_count  = 3
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_pool" {
  name                  = "additional"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.myaks01.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  min_count             = 1
  max_count             = 3
  # Removed unsupported 'enable_auto_scaling' argument
}

resource "azurerm_managed_disk" "example" {
  name                 = "myManagedDisk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "kubernetes_persistent_volume" "example" {
  metadata {
    name = "example-pv"
  }

  spec {
    capacity = {
      storage = "10Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      azure_disk {
        disk_name    = azurerm_managed_disk.example.name
        data_disk_uri = azurerm_managed_disk.example.id
        kind         = "Managed"
        caching_mode = "ReadWrite"
      }
    }
  }
}
