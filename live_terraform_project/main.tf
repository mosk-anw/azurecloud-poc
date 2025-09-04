# Resource Group
module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"
  name     = var.resource_group_name
  location = var.location
}
# Virtual Machine
module "virtual_machine" {
  source  = "Azure/avm-res-compute/virtualmachine/azurerm"
  version = "~> 0.1.0"
  name = var.name
  specifications = var.specifications
  resource_group_name = module.resource_group.name
  location            = var.location
  size = var.size
  admin_username = var.admin_username
  os_disk = var.os_disk
  os_type = var.os_type
  os_image = var.os_image
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
variable "name" {
  description = "Name"
  type        = string
  default     = "Ubuntu VM"
}
variable "specifications" {
  description = "Specifications"
  type        = string
  default     = "with public IP"
}
variable "size" {
  description = "Size"
  type        = string
  default     = "Standard_DS2_v2"
}
variable "admin_username" {
  description = "Admin Username"
  type        = string
  default     = "admin"
}
variable "os_disk" {
  description = "Os Disk"
  type        = string
  default     = "{'os_type': 'Linux', 'os_publisher': 'Canonical', 'os_offer': 'Ubuntu'}"
}
variable "os_type" {
  description = "Os Type"
  type        = string
  default     = "Linux"
}
variable "os_image" {
  description = "Os Image"
  type        = string
  default     = "{'publisher': 'Canonical', 'offer': '0001-com-ubuntu-server-jammy', 'sku': '22_04-lts-gen2', 'version': 'latest'}"
}