# Resource Group
module "resource_group" {
  source  = "Azure/avm-res-resources/resourcegroup/azurerm"
  version = "~> 0.1.0"
  location            = var.location
  name = var.name
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
  default     = "rg-devops-ai-poc-02"
}