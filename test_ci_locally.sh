#!/bin/bash
set -e

echo "🧪 Testing CI Pipeline Locally..."

# Test terraform formatting
echo "📝 Checking Terraform formatting..."
cd live_terraform_project
terraform fmt -check -recursive && echo "✅ Formatting is good" || echo "❌ Formatting needs fixes"

# Test validation for each environment
for env in development staging production; do
  echo "🔍 Testing validation for $env environment..."
  
  # Create temp directory for this environment
  temp_dir="/tmp/terraform_test_$env"
  rm -rf $temp_dir
  mkdir -p $temp_dir
  
  # Copy all files except backend configs
  cp main.tf variables.tf $temp_dir/
  
  # Copy the specific backend config
  cp backend-$env.tf $temp_dir/backend.tf
  
  cd $temp_dir
  
  # Initialize without backend for validation
  terraform init -backend=false
  terraform validate && echo "✅ $env validation passed" || echo "❌ $env validation failed"
  
  cd - > /dev/null
  rm -rf $temp_dir
done

echo "🎉 Local CI simulation complete!"
