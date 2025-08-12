variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "southindia"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for accessing the virtual machine."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "development"
    project     = "static-website"
  }
}
