# Variables for Azure Resource Group configuration
# Following Terraform best practices for variable definitions

variable "resource_group_name" {
  description = "Name of the resource group. Must be unique within the subscription."
  type        = string
  default     = "production-rg"
  
  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "Resource group name must be between 1 and 90 characters."
  }
}

variable "location" {
  description = "Azure region where the resource group will be created"
  type        = string
  default     = "UK South"
  
  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3",
      "Central US", "North Central US", "South Central US", "West Central US",
      "UK South", "UK West", "North Europe", "West Europe",
      "East Asia", "Southeast Asia", "Japan East", "Japan West",
      "Australia East", "Australia Southeast", "Australia Central",
      "Canada Central", "Canada East", "Brazil South", "South Africa North"
    ], var.location)
    error_message = "The location must be a valid Azure region."
  }
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
  default     = "30004a29-bd77-41c7-b860-68e2dad43e08"
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default = {
    Environment = "development"
    CreatedBy   = "terraform"
    Purpose     = "infrastructure-automation"
    Owner       = "devops-team"
  }
}
