#!/bin/bash
# ~/scripts/context.sh

echo "🔍 What was I working on?"
echo ""

echo "📝 Recent commits:"
git --no-pager log --oneline -5
echo ""

echo "📂 Files I changed recently:"
git --no-pager diff --name-only HEAD~3..HEAD
echo ""

echo "🚧 Current status:"
git --no-pager status --porcelain
echo ""

echo "💭 TODOs in recent files:"
git --no-pager diff --name-only HEAD~3..HEAD | xargs grep -l "TODO\|FIXME\|NOTE" 2>/dev/null | head -3 | xargs grep "TODO\|FIXME\|NOTE" 2>/dev/null
echo ""

echo "💡 Copy this info and ask your AI: 'What was I working on and what should I do next?'"
