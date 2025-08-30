# Production Environment Configuration
environment = "prod"
location = "eastus"
sku_tier = "Standard"
replication_type = "ZRS"

# Tags
tags = {
  "Environment": "production",
  "Purpose": "live-workload",
  "CostCenter": "production"
}
