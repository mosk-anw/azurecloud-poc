# Remote State Demo Project

This is a live Terraform project created by the Remote State Manager test.

## What's included

- `main.tf` - Simple Azure infrastructure (Resource Group + Storage Account)
- `variables.tf` - Variable definitions
- `outputs.tf` - Output definitions
- `terraform.tfvars` - Variable values (with unique names)

## How to use

### Option 1: Manual Terraform (without remote state)

```bash
cd live_terraform_project
terraform init
terraform plan
terraform apply
```

### Option 2: With Remote State Manager (recommended)

The Remote State Manager can:
1. Set up Azure Storage backend automatically
2. Migrate your local state to remote
3. Configure team collaboration features

To use with Remote State Manager, you can integrate it into the main DevOps Agent workflow.

## Generated Configuration

This project was automatically generated with unique resource names to avoid conflicts.

## Cleanup

To destroy the resources:

```bash
terraform destroy
```

## Next Steps

This demonstrates how the Remote State Manager can create production-ready Terraform projects with proper:
- Resource naming conventions
- Variable organization
- Output definitions
- Backend configuration ready for migration
# GitOps Test - Tue Sep  2 22:47:07 BST 2025
