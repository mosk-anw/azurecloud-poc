# Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    created_by   = "devops-ai-agent"
  }
}
# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
}
# AKS Cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "${var.resource_group_name}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "${var.resource_group_name}-aks"
  kubernetes_version  = var.kubernetes_version
  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = var.environment
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
variable "vnet_address_space" {
  description = "Address space for virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
  default     = "1.27.0"
}
variable "node_count" {
  description = "Number of nodes in AKS cluster"
  type        = number
  default     = 3
}