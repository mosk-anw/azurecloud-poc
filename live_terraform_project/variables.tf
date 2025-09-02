variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "testeurop"
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "West Europe"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}