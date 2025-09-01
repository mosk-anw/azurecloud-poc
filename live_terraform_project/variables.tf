variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "e2e-test-avm-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
