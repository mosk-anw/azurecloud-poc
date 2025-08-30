# Security and Compliance Policy for GitOps

## Access Control
- All infrastructure changes must go through Git workflow
- No direct Azure portal modifications allowed
- Service principal authentication only
- RBAC enforced through Azure AD

## Approval Requirements
- Development: Automatic deployment on feature branch
- Staging: Automatic deployment, team notification required
- Production: Manual approval required from Infrastructure + Security teams

## Security Scanning
- Terraform security scanning with checkov and tfsec
- Policy-as-code validation
- Vulnerability scanning in CI/CD pipeline
- Compliance checks against company policies

## State Management
- Remote state storage in Azure Storage
- State encryption at rest and in transit
- State versioning and backup enabled
- Access logging and audit trail

## Monitoring and Alerting
- Drift detection every 6 hours
- Automated remediation for non-production environments
- Manual approval for production drift remediation
- Slack/Teams notifications for all deployments

## Incident Response
- Emergency break-glass procedures documented
- Rollback procedures using Git revert + state restore
- Escalation paths for critical infrastructure issues
- Post-incident review process
