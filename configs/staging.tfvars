# Staging Environment Configuration
environment = "stg"
resource_group_base_name = "devops-ai"
location = "Central US"

tags = {
  environment = "stg"
  project     = "devops-agent-demo"
  managed_by  = "terraform"
  cost_center = "staging"
}
