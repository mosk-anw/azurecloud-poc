#!/bin/bash
set -e

echo "🚀 Bootstrapping Azure Backend Infrastructure"
echo "============================================="

# Check if Azure CLI is logged in
if ! az account show &>/dev/null; then
    echo "❌ Please login to Azure CLI first: az login"
    exit 1
fi

# Get current subscription
SUBSCRIPTION=$(az account show --query name -o tsv)
echo "📋 Using Azure subscription: $SUBSCRIPTION"

# Create a temporary directory for bootstrap
mkdir -p bootstrap-temp
cd bootstrap-temp

# Copy the backend infrastructure file
cp ../backend-infrastructure.tf .

# Create minimal provider configuration for bootstrap
cat > provider.tf << 'PROVIDER_EOF'
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
PROVIDER_EOF

echo "🔄 Initializing Terraform..."
terraform init

echo "📋 Planning backend infrastructure..."
terraform plan

echo "🚀 Deploying backend infrastructure..."
terraform apply -auto-approve

echo "✅ Backend infrastructure deployed successfully!"
echo ""
echo "📝 Next steps:"
echo "1. The GitOps workflow can now use remote state"
echo "2. Backend storage accounts and containers are ready"
echo "3. You can now test the GitOps workflow with remote state"

# Clean up
cd ..
rm -rf bootstrap-temp

echo "🧹 Bootstrap cleanup completed"
