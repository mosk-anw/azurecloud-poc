# GitOps Workflow with Remote State Manager

This project implements a complete GitOps workflow using Terraform and Azure remote state management.

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Git Repository │    │  GitHub Actions │    │ Azure Resources │
│                 │    │                 │    │                 │
│  Infrastructure │───▶│ GitOps Workflow │───▶│ Deployed        │
│  as Code        │    │                 │    │ Infrastructure  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Branch Strategy │    │ Remote State    │    │ Drift Detection │
│ • feature/*     │    │ Management      │    │ & Monitoring    │
│ • develop       │    │                 │    │                 │
│ • main          │    │ Azure Storage   │    │ Auto Remediation│
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🌍 Environments

| Environment | Branch Pattern | Auto Deploy | Approval Required | State Key |
|-------------|---------------|-------------|-------------------|-----------|
| Development | `feature/*`   | ✅ Yes      | ❌ No             | `dev/terraform.tfstate` |
| Staging     | `develop`     | ✅ Yes      | ✅ Yes            | `staging/terraform.tfstate` |
| Production  | `main`        | ❌ No       | ✅ Yes            | `prod/terraform.tfstate` |

## 🚀 Workflow

### 1. Development
1. Create feature branch: `git checkout -b feature/new-storage`
2. Modify Terraform files
3. Commit and push: triggers development deployment
4. Review in Azure portal

### 2. Staging
1. Create PR: `feature/new-storage` → `develop`
2. Team reviews infrastructure changes
3. Merge triggers staging deployment
4. Integration tests run

### 3. Production
1. Create PR: `develop` → `main`
2. Required approvals from Infrastructure + Security teams
3. Manual deployment trigger
4. Production resources deployed

## 🔍 Drift Detection

Automatic drift detection runs every 6 hours:
- Compares actual Azure resources vs Terraform state
- Creates alerts for unauthorized changes
- Auto-remediation for dev/staging (manual for production)

Run manual drift detection:
```bash
./detect-drift.sh staging
./detect-drift.sh production
```

## 🔒 Security

- **No Direct Access**: All changes through Git workflow
- **Service Principal**: Automated authentication
- **State Encryption**: Remote state encrypted in Azure Storage
- **Audit Trail**: Git history + Azure Activity Log
- **RBAC**: Azure AD integration

## 📊 Monitoring

- GitHub Actions workflow status
- Azure Resource health monitoring
- State consistency checks
- Cost tracking and alerts

## 🚨 Emergency Procedures

### Rollback
1. Git revert to previous commit
2. GitOps workflow deploys previous state
3. Verify infrastructure health

### Break Glass
1. Emergency Azure portal access (documented separately)
2. Manual Terraform operations
3. Update Git to reflect manual changes
4. Resume GitOps workflow

## 📋 Getting Started

1. **Setup Azure Service Principal**:
   ```bash
   az ad sp create-for-rbac --name "gitops-terraform" --role="Contributor"
   ```

2. **Configure GitHub Secrets**:
   - `AZURE_CLIENT_ID`
   - `AZURE_CLIENT_SECRET` 
   - `AZURE_SUBSCRIPTION_ID`
   - `AZURE_TENANT_ID`

3. **Deploy Backend Infrastructure**:
   ```bash
   ./deploy.sh
   ```

4. **Create Feature Branch**:
   ```bash
   git checkout -b feature/my-changes
   # Make changes
   git commit -am "Add new storage account"
   git push origin feature/my-changes
   ```

5. **Monitor Deployment**:
   - Check GitHub Actions for workflow status
   - Review Azure portal for deployed resources
   - Verify drift detection is working

## 📚 Additional Resources

- [Security Policy](SECURITY_POLICY.md)
- [Compliance Checklist](COMPLIANCE_CHECKLIST.md)
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)
- [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
