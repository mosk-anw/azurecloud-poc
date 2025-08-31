# GitOps Compliance Checklist

## Pre-Deployment
- [ ] Terraform code reviewed by team
- [ ] Security scan passed (checkov, tfsec)
- [ ] Cost estimation reviewed
- [ ] Change management approval (for production)
- [ ] Backup of current state taken

## Deployment
- [ ] Deployment executed through GitOps workflow
- [ ] No manual Azure portal changes
- [ ] Remote state properly locked during deployment
- [ ] Deployment logs captured and stored

## Post-Deployment
- [ ] Infrastructure health verified
- [ ] Monitoring and alerting configured
- [ ] Documentation updated
- [ ] Team notified of changes
- [ ] State backup verified

## Audit Requirements
- [ ] Git commit history preserved
- [ ] Azure Activity Log retention configured
- [ ] State change history maintained
- [ ] Access logs reviewed monthly
- [ ] Compliance report generated quarterly
