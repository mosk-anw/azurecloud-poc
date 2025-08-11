variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "testrg786"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "us"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "testvm"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {
    environment = "test"
  }
}
