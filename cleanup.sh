#!/bin/bash
# Cleanup script for the demo project

echo "🧹 Cleaning up Remote State Demo Project"
echo "======================================"

# Navigate to project directory
cd "$(dirname "$0")"

echo "📁 Working directory: $(pwd)"

# Check if state file exists
if [ ! -f "terraform.tfstate" ] && [ ! -f "terraform.tf" ]; then
    echo "ℹ️  No Terraform state found. Nothing to clean up."
    exit 0
fi

# Show what will be destroyed
echo "🔍 Checking what will be destroyed..."
terraform plan -destroy

if [ $? -ne 0 ]; then
    echo "❌ Failed to create destroy plan"
    exit 1
fi

# Ask for confirmation
echo ""
echo "⚠️  This will DESTROY all resources shown above. Are you sure? (y/N)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "🗑️  Destroying resources..."
    terraform destroy -auto-approve
    
    if [ $? -eq 0 ]; then
        echo "✅ Resources destroyed successfully!"
        
        # Clean up generated files
        echo "🧹 Cleaning up generated files..."
        rm -f terraform.tfstate*
        rm -f tfplan
        rm -f .terraform.lock.hcl
        rm -rf .terraform/
        
        echo "✅ Cleanup completed!"
    else
        echo "❌ Destroy failed"
        exit 1
    fi
else
    echo "🛑 Cleanup cancelled by user"
fi
