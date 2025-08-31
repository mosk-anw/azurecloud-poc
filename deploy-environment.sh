#!/bin/bash
# Environment-specific deployment script for GitOps workflow

set -e

ENVIRONMENT=${1:-development}
BACKEND_FILE="backend-${ENVIRONMENT}.tf"
TFVARS_FILE="terraform-${ENVIRONMENT}.tfvars"

echo "🚀 Deploying to ${ENVIRONMENT} environment"

# Validate inputs
if [ ! -f "$BACKEND_FILE" ]; then
    echo "❌ Backend file $BACKEND_FILE not found"
    exit 1
fi

if [ ! -f "$TFVARS_FILE" ]; then
    echo "❌ Variables file $TFVARS_FILE not found"
    exit 1
fi

# Configure backend for this environment
echo "🔧 Configuring backend for ${ENVIRONMENT}..."
cp "$BACKEND_FILE" backend.tf

# Initialize Terraform
echo "🚀 Initializing Terraform..."
terraform init

# Validate configuration
echo "📋 Validating configuration..."
terraform validate

# Plan deployment
echo "📊 Creating deployment plan..."
terraform plan -var-file="$TFVARS_FILE" -out="tfplan-${ENVIRONMENT}"

# Confirm deployment
if [ "$2" != "--auto-approve" ]; then
    echo "🤔 Do you want to apply this plan? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "❌ Deployment cancelled"
        exit 0
    fi
fi

# Apply deployment
echo "🚀 Applying deployment..."
terraform apply "tfplan-${ENVIRONMENT}"

echo "✅ Deployment to ${ENVIRONMENT} completed successfully!"
echo "🌍 Environment: ${ENVIRONMENT}"
echo "🗄️ State: Remote backend in Azure Storage"
echo "📋 GitOps: Ready for next steps"
