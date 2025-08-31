# GitOps Setup Instructions

## Quick Start

### 1. Deploy Backend Infrastructure (One-time setup)

First, deploy the backend storage for all environments:

```bash
# Deploy backend infrastructure
terraform init
terraform plan -target="azurerm_resource_group.terraform_state_dev" -target="azurerm_storage_account.terraform_state_dev" -target="azurerm_storage_container.terraform_state_dev"
terraform apply -target="azurerm_resource_group.terraform_state_dev" -target="azurerm_storage_account.terraform_state_dev" -target="azurerm_storage_container.terraform_state_dev"

# Repeat for staging and production as needed
```

### 2. Deploy to Specific Environment

```bash
# Deploy to development
./deploy-environment.sh development

# Deploy to staging  
./deploy-environment.sh staging

# Deploy to production (with manual approval)
./deploy-environment.sh production
```

### 3. Test Drift Detection

```bash
# Test drift detection
./detect-drift.sh development
./detect-drift.sh staging
./detect-drift.sh production
```

## GitOps Workflow

### Branch Strategy
- `feature/*` → Development environment (automatic)
- `develop` → Staging environment (automatic)
- `main` → Production environment (manual approval)

### File Structure
```
live_terraform_project/
├── backend-development.tf     # Dev backend config
├── backend-staging.tf         # Staging backend config  
├── backend-production.tf      # Prod backend config
├── backend-infrastructure.tf  # Backend resources
├── terraform-development.tfvars
├── terraform-staging.tfvars
├── terraform-production.tfvars
├── deploy-environment.sh      # Environment deployment
├── detect-drift.sh           # Drift detection
└── .github/workflows/        # GitOps automation
```

### GitHub Actions Integration

The workflow automatically:
1. Detects target environment from branch
2. Configures appropriate backend
3. Runs terraform plan
4. Posts results to PR (if applicable)  
5. Deploys on merge (with approvals)
6. Monitors for drift

### Security Features

- ✅ No direct Azure access required
- ✅ Service principal authentication
- ✅ Remote state encryption
- ✅ State locking prevents conflicts
- ✅ Complete audit trail
- ✅ Policy-as-code enforcement

## Troubleshooting

### Backend Configuration Issues
If you see duplicate backend errors:
```bash
# Clean up conflicting files
rm -f backend.tf backend_resources.tf

# Use environment-specific backend
cp backend-development.tf backend.tf
terraform init
```

### State Migration
To migrate from local to remote state:
```bash
# Configure remote backend
cp backend-development.tf backend.tf

# Initialize with migration
terraform init -migrate-state
```

### Emergency Access
For emergency situations:
1. Use Azure portal for immediate fixes
2. Update Terraform to match manual changes
3. Resume GitOps workflow

## Next Steps

1. ✅ Setup Azure Service Principal  
2. ✅ Configure GitHub repository secrets
3. ✅ Deploy backend infrastructure
4. ✅ Test environment deployments
5. ✅ Enable drift detection
6. ✅ Train team on GitOps workflow
