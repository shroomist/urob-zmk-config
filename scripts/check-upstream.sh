#!/bin/bash
# Check if fork is behind upstream

cd "$(dirname "$0")/.."
git fetch upstream 2>/dev/null

BEHIND=$(git rev-list --count HEAD..upstream/main)

if [ $BEHIND -gt 0 ]; then
    echo "⚠️  Fork is $BEHIND commits behind upstream"
    echo ""
    echo "Recent upstream changes:"
    git log --oneline --no-decorate HEAD..upstream/main | head -10
    echo ""
    echo "To sync: git fetch upstream && git merge upstream/main"
else
    echo "✅ Fork is up to date with upstream"
fi
