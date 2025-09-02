# Variables for this Terraform configuration
# Edit these values according to your requirements

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-remote-state-demo"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
  default     = "stremotestatedemo001"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "demo"
    ManagedBy   = "terraform"
    Project     = "azurecloud-poc"
  }
}
