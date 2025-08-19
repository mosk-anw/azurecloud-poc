# Variables for Azure Kubernetes Service (AKS)
# Following Azure Verified Module patterns

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "myaks-cluster-rg"
  
  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "Resource group name must be between 1 and 90 characters."
  }
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "UK South"
  
  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3",
      "Central US", "North Central US", "South Central US", "West Central US",
      "UK South", "UK West", "North Europe", "West Europe",
      "Southeast Asia", "East Asia", "Japan East", "Japan West",
      "Australia East", "Australia Southeast", "Canada Central", "Canada East"
    ], var.location)
    error_message = "The location must be a valid Azure region."
  }
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "myaks-cluster"
  
  validation {
    condition     = length(var.cluster_name) >= 1 && length(var.cluster_name) <= 63
    error_message = "Cluster name must be between 1 and 63 characters."
  }
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "myaks-cluster"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.dns_prefix))
    error_message = "DNS prefix must contain only alphanumeric characters and hyphens."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = "1.28"
}

variable "node_count" {
  description = "Number of nodes in the system node pool"
  type        = number
  default     = 3
  
  validation {
    condition     = var.node_count >= 1 && var.node_count <= 1000
    error_message = "Node count must be between 1 and 1000."
  }
}

variable "vm_size" {
  description = "Size of the Virtual Machines for system node pool"
  type        = string
  default     = "Standard_D2s_v3"
  
  validation {
    condition = contains([
      "Standard_B2s", "Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3",
      "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_E2s_v3"
    ], var.vm_size)
    error_message = "VM size must be a valid Azure VM size."
  }
}

variable "user_node_count" {
  description = "Number of nodes in the user node pool"
  type        = number
  default     = 2
  
  validation {
    condition     = var.user_node_count >= 0 && var.user_node_count <= 1000
    error_message = "User node count must be between 0 and 1000."
  }
}

variable "user_vm_size" {
  description = "Size of the Virtual Machines for user node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling for node pools"
  type        = bool
  default     = true
}

variable "min_count" {
  description = "Minimum number of nodes when auto scaling is enabled"
  type        = number
  default     = 1
  
  validation {
    condition     = var.min_count >= 1 && var.min_count <= 1000
    error_message = "Minimum count must be between 1 and 1000."
  }
}

variable "max_count" {
  description = "Maximum number of nodes when auto scaling is enabled"
  type        = number
  default     = 10
  
  validation {
    condition     = var.max_count >= 1 && var.max_count <= 1000
    error_message = "Maximum count must be between 1 and 1000."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "terraform"
    Service     = "aks"
    CostCenter  = "engineering"
  }
}
