variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account should be created."
  type        = string
  default     = "uk"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
  default     = "ukbucket01"
}
