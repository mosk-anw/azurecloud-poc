#!/usr/bin/env python3

"""
Update GitOps workflow to implement proper branch-to-environment mapping:
- develop branch → development environment 
- staging branch → staging environment
- main branch → production environment
"""

import re

def update_workflow():
    with open('.github/workflows/gitops-deployment.yml', 'r') as f:
        content = f.read()
    
    # Plan Development: trigger on develop branch or PRs to develop
    content = re.sub(
        r'(\s+if: )github\.ref == \'refs/heads/main\' \|\| github\.event_name == \'pull_request\'',
        r'\1github.ref == \'refs/heads/develop\' || (github.event_name == \'pull_request\' && github.base_ref == \'develop\')',
        content
    )
    
    # Deploy Development: trigger on develop branch pushes
    content = re.sub(
        r'(\s+if: )github\.ref == \'refs/heads/main\' && github\.event_name == \'push\'',
        r'\1github.ref == \'refs/heads/develop\' && github.event_name == \'push\'',
        content,
        count=1  # Only replace the first occurrence (deploy-development)
    )
    
    # Plan Staging: trigger on develop branch pushes (after development deployment)
    # This stays as-is since it needs deploy-development to complete first
    
    # Deploy Staging: trigger on staging branch pushes  
    content = re.sub(
        r'(deploy-staging:.*?if: )github\.ref == \'refs/heads/main\' && github\.event_name == \'push\'',
        r'\1github.ref == \'refs/heads/staging\' && github.event_name == \'push\'',
        content,
        flags=re.DOTALL
    )
    
    # Plan Production: trigger on staging branch pushes (after staging deployment)
    content = re.sub(
        r'(plan-production:.*?if: )github\.ref == \'refs/heads/main\' && github\.event_name == \'push\'',
        r'\1github.ref == \'refs/heads/staging\' && github.event_name == \'push\'',
        content,
        flags=re.DOTALL
    )
    
    # Deploy Production: trigger on main branch pushes (keep as-is)
    # This should remain as main branch
    
    with open('.github/workflows/gitops-deployment.yml', 'w') as f:
        f.write(content)
    
    print("✅ GitOps workflow updated with proper branch-to-environment mapping")
    print("🚀 Branch mapping:")
    print("   develop → development environment")
    print("   staging → staging environment") 
    print("   main → production environment")

if __name__ == "__main__":
    update_workflow()
