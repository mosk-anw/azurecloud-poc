# Production Environment Configuration
environment              = "prod"
resource_group_base_name = "devops-ai"
location                 = "West US 2"

tags = {
  environment = "prod"
  project     = "devops-agent-demo"
  managed_by  = "terraform"
  cost_center = "production"
}
