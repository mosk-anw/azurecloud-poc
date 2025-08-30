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
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"
}
