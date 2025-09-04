# Resource Group
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"
  name     = var.resource_group_name
  location = var.location
}
# Resource Group
module "resource_group" {
  source  = "Azure/avm-res-resources/resourcegroup/azurerm"
  version = "~> 0.1.0"
  name = var.name
  location            = var.location
  size = var.size
  resource_group_name = module.resource_group.name
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
variable "name" {
  description = "Name"
  type        = string
  default     = "rg-devops-ai-poc-01"
}
variable "size" {
  description = "Size"
  type        = string
  default     = "Standard_B2s"
}