# 🚀 Terraform CI/CD Workflows Documentation

## Overview

This repository implements a **strict GitOps promotion strategy** with separate CI and CD workflows for better control, visibility, and environment isolation.

## 🎯 Workflow Architecture

```
Feature Branch → develop → staging → main
     ↓             ↓        ↓        ↓
   (PR+CI)      (PR+CI)  (PR+CI)  (PR+CI)
     ↓             ↓        ↓        ↓
   Merge         Merge    Merge    Merge
     ↓             ↓        ↓        ↓
    N/A        Deploy     Deploy   Deploy
               (Dev)      (Stg)    (Prod)
```

## 📋 Workflow Files

### 1. **Terraform CI** (`terraform-ci.yml`)
- **Purpose**: Validation and planning for PRs
- **Triggers**: Pull requests to `develop`, `staging`, `main`
- **Actions**:
  - Security scanning with Checkov
  - Terraform format checking (auto-fix)
  - Terraform validation
  - Environment-specific planning
  - PR comments with plan results

### 2. **Terraform CD** (`terraform-cd.yml`)
- **Purpose**: Deployment after merge
- **Triggers**: Push to `develop`, `staging`, `main`
- **Actions**:
  - Deploy to development (from develop)
  - Deploy to staging (from staging)
  - Deploy to production (from main, with approval gate)

### 3. **Environment Promotion** (`environment-promotion.yml`)
- **Purpose**: Create promotion PRs between environments
- **Triggers**: Manual workflow dispatch
- **Actions**:
  - Validate promotion prerequisites
  - Create promotion branch
  - Generate promotion PR with details
  - Add appropriate labels

## 🎯 Promotion Strategy

### Strict Sequential Flow
1. **Feature → develop**: Direct PR from feature branches
2. **develop → staging**: Via Environment Promotion workflow
3. **staging → main**: Via Environment Promotion workflow

### Branch Protection Rules
- **develop**: Requires PR, CI checks must pass
- **staging**: Only accepts PRs from promotion workflow
- **main**: Only accepts PRs from promotion workflow, requires approval

## 🛠️ Key Improvements

### ✅ **Learned from Previous Workflow**
- **Terraform 1.9.7**: Latest version for AVM compatibility
- **Proper permissions**: All required Azure and GitHub permissions
- **Environment isolation**: Separate backends and tfvars
- **Error handling**: Robust backend setup and validation
- **Security scanning**: Integrated Checkov security checks
- **Auto-formatting**: Terraform fmt auto-fix on CI

### ✅ **New CI/CD Benefits**
- **Fast PR feedback**: CI validation completes quickly
- **Independent deployments**: CD can be retried separately
- **Manual approval gates**: Production requires approval
- **Environment promotion**: Controlled promotion workflow
- **Clear separation**: CI for validation, CD for deployment

## 🔧 Configuration Files

### Environment Configurations (`configs/`)
```
configs/
├── development.tfvars  # Dev environment variables
├── staging.tfvars      # Staging environment variables
└── production.tfvars   # Production environment variables
```

### Backend Configurations (`live_terraform_project/`)
```
live_terraform_project/
├── backend-development.tf  # Dev backend state
├── backend-staging.tf      # Staging backend state
└── backend-production.tf   # Production backend state
```

## 🚀 Usage Guide

### 1. **Feature Development**
```bash
# Create feature branch
git checkout -b feature/my-feature develop

# Make changes, commit, push
git add . && git commit -m "feat: add new resource"
git push origin feature/my-feature

# Create PR to develop
gh pr create --base develop --title "feat: add new resource"
```

### 2. **Promote to Staging**
1. Go to Actions tab
2. Select "Environment Promotion" workflow
3. Click "Run workflow"
4. Choose "develop-to-staging"
5. Review and approve the generated PR

### 3. **Promote to Production**
1. Go to Actions tab
2. Select "Environment Promotion" workflow
3. Click "Run workflow"
4. Choose "staging-to-production"
5. Review and approve the generated PR

### 4. **Manual Deployment**
```bash
# Trigger manual deployment
gh workflow run terraform-cd.yml -f environment=development -f action=apply
```

## 🔍 Monitoring

### CI Pipeline Status
- **Security Scan**: Checkov security analysis
- **Validation**: Terraform syntax and logic
- **Planning**: Environment-specific plans
- **PR Comments**: Automatic plan summaries

### CD Pipeline Status
- **Deployment Status**: Success/failure per environment
- **Output Verification**: Post-deployment checks
- **Manual Approvals**: Production gate status

## 🛡️ Security Features

- **Checkov Security Scanning**: Automated security policy checks
- **SARIF Upload**: Security findings in GitHub Security tab
- **Manual Approval Gates**: Production deployment requires approval
- **Environment Isolation**: Separate backends and configurations
- **Least Privilege**: Minimal required permissions

## 🎯 Environment Naming

Resources use short suffixes for environment isolation:
- **Development**: `rg-devops-ai-dev`, `stdevopsaidev`
- **Staging**: `rg-devops-ai-stg`, `stdevopsaistg`
- **Production**: `rg-devops-ai-prod`, `stdevopsaiprod`

## 📊 Benefits Summary

| Aspect | Old Monolithic | New CI/CD |
|--------|----------------|-----------|
| **PR Feedback** | Slow (includes deployment) | Fast (validation only) |
| **Deployment Control** | Limited | Full control with gates |
| **Environment Isolation** | Basic | Complete separation |
| **Promotion Path** | Manual/unclear | Automated workflow |
| **Rollback** | Complex | Environment-specific |
| **Security** | Basic | Enhanced with gates |
| **Monitoring** | Limited visibility | Clear status tracking |

## 🔗 Related Documentation

- [Azure Verified Modules (AVM)](https://github.com/Azure/terraform-azurerm-avm)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [GitHub Actions Workflows](https://docs.github.com/en/actions/using-workflows)

---

**🤖 Powered by DevOps AI Agent with Environment-Specific Naming Support**
