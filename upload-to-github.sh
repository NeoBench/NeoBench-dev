#!/bin/bash
set -e

REPO_NAME="neobench-dev"
GITHUB_USER=$(gh api user | jq -r .login)

echo "📦 Preparing Git repository..."
cd "$(dirname "$0")"

# Init if not already a repo
if [ ! -d ".git" ]; then
  git init
  echo "📝 Initialized git repo."
fi

# Add and commit
git add .
git commit -m "Initial upload of NeoBench-dev"
echo "✅ Code committed."

# Create remote repo if needed
if ! git remote | grep origin > /dev/null; then
  echo "🌐 Creating GitHub repo: $REPO_NAME"
  gh repo create "$GITHUB_USER/$REPO_NAME" --private --source=. --remote=origin --push
else
  echo "🚀 Pushing to GitHub..."
  git push -u origin main || git push -u origin master
fi

echo "✅ Upload complete."
