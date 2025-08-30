#!/bin/bash
# Drift Detection Script for GitOps Workflow

set -e

ENVIRONMENT=${1:-staging}
BACKEND_FILE="backend-${ENVIRONMENT}.tf"

echo "🔍 Starting drift detection for ${ENVIRONMENT} environment"

# Check if backend file exists
if [ ! -f "$BACKEND_FILE" ]; then
    echo "❌ Backend file $BACKEND_FILE not found"
    exit 1
fi

# Configure backend
cp "$BACKEND_FILE" backend.tf

# Initialize Terraform
echo "🚀 Initializing Terraform..."
terraform init -input=false

# Run plan to detect drift
echo "📊 Checking for drift..."
terraform plan -detailed-exitcode -no-color

EXIT_CODE=$?

case $EXIT_CODE in
    0)
        echo "✅ No drift detected - infrastructure matches Terraform state"
        ;;
    1)
        echo "❌ Terraform plan failed - check configuration"
        exit 1
        ;;
    2)
        echo "🚨 DRIFT DETECTED - infrastructure differs from Terraform state"
        echo "📋 Manual review and remediation required"
        
        # For non-production environments, could auto-remediate here
        if [ "$ENVIRONMENT" != "production" ]; then
            echo "🔧 Auto-remediation available for $ENVIRONMENT"
            echo "Run: terraform apply -auto-approve"
        fi
        
        exit 2
        ;;
esac

echo "🎉 Drift detection completed successfully"
