variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "testrg"
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "india"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "webhost-vm"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for the virtual machine"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {
    environment = "test"
    project     = "webhosting"
  }
}
