variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "production-rg"
}

variable "location" {
  description = "The Azure region where the resource group should be created"
  type        = string
  default     = "UK South"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
