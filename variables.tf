variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "testrg786"
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "asia"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "testvm"
}

variable "admin_username" {
  description = "The admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for the Linux VM"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {
    environment = "test"
    project     = "web-hosting"
  }
}
