variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "ecommerce-rg"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "uscentral"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "vmecomapp01"
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "The SSH public key for the admin user"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
}

variable "database_name" {
  description = "The name of the database"
  type        = string
  default     = "ecomdb01"
}
