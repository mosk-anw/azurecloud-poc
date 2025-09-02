module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "~> 0.1"

  name     = "test-rg-777"
  location = "uksouth"

  tags = {
    "environment" = "demo"
    "managed_by"  = "devops_ai_agent"
  }
}