#!/bin/bash
# Simple deployment script for the demo project

echo "🚀 Deploying Remote State Demo Project"
echo "======================================"

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform not found. Please install Terraform first."
    exit 1
fi

# Check if Azure CLI is installed and logged in
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI not found. Please install Azure CLI first."
    exit 1
fi

# Check Azure login
if ! az account show &> /dev/null; then
    echo "❌ Not logged into Azure. Please run 'az login' first."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Navigate to project directory
cd "$(dirname "$0")"

echo "📁 Working directory: $(pwd)"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

if [ $? -ne 0 ]; then
    echo "❌ Terraform init failed"
    exit 1
fi

# Validate configuration
echo "🔍 Validating Terraform configuration..."
terraform validate

if [ $? -ne 0 ]; then
    echo "❌ Terraform validation failed"
    exit 1
fi

# Plan deployment
echo "📋 Creating deployment plan..."
terraform plan -out=tfplan

if [ $? -ne 0 ]; then
    echo "❌ Terraform plan failed"
    exit 1
fi

# Ask for confirmation
echo ""
echo "📊 Review the plan above. Do you want to apply these changes? (y/N)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "🚀 Applying Terraform configuration..."
    terraform apply tfplan
    
    if [ $? -eq 0 ]; then
        echo "✅ Deployment completed successfully!"
        echo ""
        echo "📄 Outputs:"
        terraform output
        
        echo ""
        echo "🎯 Next steps:"
        echo "  • Review the created resources in Azure portal"
        echo "  • Consider enabling remote state with: mv backend.tf.example terraform.tf"
        echo "  • Run 'terraform destroy' when you're done testing"
    else
        echo "❌ Deployment failed"
        exit 1
    fi
else
    echo "🛑 Deployment cancelled by user"
    rm -f tfplan
fi
