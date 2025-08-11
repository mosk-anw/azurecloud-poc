variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "india"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "mytestbucket01"
}
