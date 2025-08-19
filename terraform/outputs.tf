
# Outputs will be generated based on AVM modules
output "deployment_info" {
  description = "Deployment information"
  value = {
    environment = var.environment
    location    = var.location
    timestamp   = timestamp()
  }
}
