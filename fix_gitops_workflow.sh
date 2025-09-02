#!/bin/bash

# Fix GitOps workflow to use proper branch-to-environment mapping
# develop -> development, staging -> staging, main -> production

sed -i.bak '
# Fix plan-development job condition
/plan-development:/,/environment: development/ {
    s/if: github\.ref == '\''refs\/heads\/main'\'' || github\.event_name == '\''pull_request'\''/if: github.ref == '\''refs\/heads\/develop'\'' || (github.event_name == '\''pull_request'\'' \&\& github.base_ref == '\''develop'\'')/
}

# Fix deploy-development job condition  
/deploy-development:/,/environment: development/ {
    s/if: github\.ref == '\''refs\/heads\/main'\'' && github\.event_name == '\''push'\''/if: github.ref == '\''refs\/heads\/develop'\'' \&\& github.event_name == '\''push'\''/
}

# Fix plan-staging job condition
/plan-staging:/,/environment: staging/ {
    s/if: github\.ref == '\''refs\/heads\/main'\'' && github\.event_name == '\''push'\''/if: github.ref == '\''refs\/heads\/staging'\'' \&\& github.event_name == '\''push'\''/
}

# Fix deploy-staging job condition - remove dependency on deploy-development
/deploy-staging:/,/environment: staging/ {
    s/needs: plan-staging/needs: plan-staging/
}

# Fix plan-production job condition - remove dependency on deploy-staging
/plan-production:/,/environment: production/ {
    s/needs: deploy-staging/needs: validate/
    s/if: github\.ref == '\''refs\/heads\/main'\'' && github\.event_name == '\''push'\''/if: github.ref == '\''refs\/heads\/main'\'' \&\& github.event_name == '\''push'\''/
}
' .github/workflows/gitops-deployment.yml

echo "GitOps workflow updated with proper branch-to-environment mapping"
