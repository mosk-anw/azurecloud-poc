variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-devops-ai-uksouth"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "UK South"
}
