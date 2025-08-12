variable "resource_group_name" {
  description = "The name of the resource group to be created."
  type        = string
  default     = "production-rg"
}

variable "location" {
  description = "The Azure region where the resource group should be created."
  type        = string
  default     = "uksouth"
}
