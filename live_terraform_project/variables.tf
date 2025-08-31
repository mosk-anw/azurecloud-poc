# Variables for this Terraform configuration
# Edit these values according to your requirements

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "default-rg"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}