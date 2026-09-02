#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
REPO_URL="https://github.com/testimiosherelene28-alt/sheque.git"
BRANCH_NAME="main"
COMMIT_MSG="Deploy Queueing System to GitHub Pages"

echo "=========================================="
echo "🚀 Starting GitHub Deployment Workflow"
echo "=========================================="

# 1. Initialize Git repository if not present
if [ ! -d ".git" ]; then
    echo "📦 Initializing local Git repository..."
    git init
else
    echo "📦 Git repository already initialized."
fi

# 2. Configure Git user identity (if not already set globally)
if [ -z "$(git config user.email)" ]; then
    echo "👤 Setting local Git configuration..."
    git config user.name "testimiosherelene28-alt"
    git config user.email "testimiosherelene28-alt@users.noreply.github.com"
fi

# 3. Stage all project files
echo "➕ Staging project files..."
git add .

# 4. Commit changes
echo "💾 Creating commit..."
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo "ℹ️  No changes detected to commit."
else
    git commit -m "$COMMIT_MSG"
fi

# 5. Rename/Ensure active branch is main
echo "🌿 Setting active branch to '$BRANCH_NAME'..."
git branch -M "$BRANCH_NAME"

# 6. Configure remote repository URL
echo "🔗 Setting remote origin to $REPO_URL..."
if git remote | grep -q "^origin$"; then
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi

# 7. Push to GitHub
echo "📤 Pushing code to GitHub..."
git push -u origin "$BRANCH_NAME"

echo "=========================================="
echo "✅ Push complete!"
echo "🌐 Configure GitHub Pages at:"
echo "   https://github.com/testimiosherelene28-alt/sheque/settings/pages"
echo "=========================================="