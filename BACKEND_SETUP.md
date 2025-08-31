# Azure Backend Infrastructure Setup

This guide explains how to set up the Azure backend infrastructure required for the GitOps workflow.

## Prerequisites

1. Azure CLI installed and configured
2. Terraform installed
3. Azure subscription with appropriate permissions

## Bootstrap Process

The GitOps workflow requires Azure Storage Accounts for Terraform remote state. These must be created first.

### Step 1: Bootstrap Backend Infrastructure

```bash
# Login to Azure
az login

# Run bootstrap script
./bootstrap-backend.sh
```

This script will:
- ✅ Create resource groups for all environments (dev, staging, prod)
- ✅ Create storage accounts for Terraform state
- ✅ Create storage containers for state files
- ✅ Use local state for the bootstrap process

### Step 2: Verify Backend Infrastructure

After bootstrap completion, verify the resources:

```bash
# Check resource groups
az group list --query "[?contains(name, 'terraform-state')].{Name:name, Location:location}" -o table

# Check storage accounts
az storage account list --query "[?contains(name, 'tfstate')].{Name:name, ResourceGroup:resourceGroup}" -o table
```

### Step 3: Test GitOps Workflow

Once backend infrastructure exists, the GitOps workflow can use remote state:

1. Create/update a PR
2. The workflow will now successfully initialize with remote state
3. Terraform operations will use Azure Storage for state management

## Backend Configuration

The following environments are configured:

| Environment | Resource Group | Storage Account | Container |
|-------------|----------------|-----------------|-----------|
| Development | rg-terraform-state-dev | tfstatedev123 | tfstate |
| Staging | rg-terraform-state-staging | tfstatestaging123 | tfstate |
| Production | rg-terraform-state-prod | tfstateprod123 | tfstate |

## Troubleshooting

### Error: Resource group could not be found
- Run the bootstrap script to create backend infrastructure
- Verify Azure CLI authentication: `az account show`

### Error: Storage account not found
- Check storage account names match in backend configurations
- Ensure bootstrap script completed successfully

### Error: Terraform init failed
- Verify backend configuration syntax
- Check Azure permissions for service principal
- Confirm storage account accessibility

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     GitOps Workflow                            │
├─────────────────────────────────────────────────────────────────┤
│ 1. PR Created/Updated                                           │
│ 2. Terraform Init (uses remote state)                          │
│ 3. Terraform Plan                                              │
│ 4. Terraform Apply (on merge)                                  │
└─────────────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Azure Backend Infrastructure                  │
├─────────────────────────────────────────────────────────────────┤
│ Resource Groups:                                                │
│ • rg-terraform-state-dev                                       │
│ • rg-terraform-state-staging                                   │
│ • rg-terraform-state-prod                                      │
│                                                                 │
│ Storage Accounts:                                               │
│ • tfstatedev123 (development)                                  │
│ • tfstatestaging123 (staging)                                  │
│ • tfstateprod123 (production)                                  │
│                                                                 │
│ Containers: tfstate (all environments)                         │
└─────────────────────────────────────────────────────────────────┘
```
