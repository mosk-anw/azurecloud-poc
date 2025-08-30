# Staging Environment Configuration
environment = "staging"
location = "eastus"
sku_tier = "Standard"
replication_type = "LRS"

# Tags
tags = {
  "Environment": "staging",
  "Purpose": "integration-testing",
  "CostCenter": "qa"
}
