#!/bin/bash

# GitHub Actions Workflow Runs Cleanup Script
REPO_OWNER="mosk-anw"
REPO_NAME="azurecloud-poc"
REPO_FULL="$REPO_OWNER/$REPO_NAME"

echo "🗑️  GitHub Actions Workflow Runs Cleanup"
echo "Repository: $REPO_FULL"
echo "=========================================="

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Please install it: brew install gh"
    echo ""
    echo "🔗 Alternative: Manual cleanup via GitHub web interface:"
    echo "   1. Go to https://github.com/$REPO_FULL/actions"
    echo "   2. Click on each workflow"
    echo "   3. Use the '...' menu to delete runs"
    exit 1
fi

echo "✅ GitHub CLI is ready"
echo ""

# List all workflow runs
echo "🔍 Listing recent workflow runs:"
gh run list --repo "$REPO_FULL" --limit 20

echo ""
read -p "❓ Delete ALL workflow runs? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "🗑️  Deleting all workflow runs..."
    
    # Get all run IDs and delete them
    gh run list --repo "$REPO_FULL" --json databaseId --jq '.[].databaseId' | while read -r run_id; do
        echo "Deleting run ID: $run_id"
        gh run delete "$run_id" --repo "$REPO_FULL" 2>/dev/null || echo "Failed to delete run $run_id"
    done
    
    echo "✅ Cleanup completed!"
else
    echo "⏭️  Cleanup cancelled"
fi

echo "🔗 View runs: https://github.com/$REPO_FULL/actions"
