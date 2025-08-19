# Terraform variables for AKS deployment
# Following Azure Verified Module patterns

resource_group_name = "myaks-cluster-rg"
location           = "UK South"
cluster_name       = "myaks-cluster"
dns_prefix         = "myaks-cluster"
kubernetes_version = "1.28"

# Node pool configuration
node_count         = 3
vm_size           = "Standard_D2s_v3"
user_node_count   = 2
user_vm_size      = "Standard_D2s_v3"

# Auto scaling
enable_auto_scaling = true
min_count          = 1
max_count          = 10

# Tags following Azure tagging standards
tags = {
  Environment = "development"
  ManagedBy   = "terraform"
  Service     = "aks"
  CostCenter  = "engineering"
  Owner       = "devops-team"
  Project     = "myaks-cluster"
  CreatedAt   = "2025-08-19T01:23:40.498557"
}
