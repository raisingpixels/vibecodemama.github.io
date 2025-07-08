---
title: "Bash Aliases for Sleep-Deprived Parent Developers"
date: "2025-07-08T05:42:27-05:00"
draft: false
description: "CLI productivity with terminal shortcuts that work even when your brain is mostly Goldfish Crackers."
categories: ["Parenting with Systems", "Developer Productivity"]
tags: ["bash", "aliases", "productivity", "cli", "automation", "git"]
---

It's 2:30 PM on a Tuesday. You've been awake since 4:32 AM (thanks, kiddo), you've just figured out the production bug, and your toddler is stirring from their nap. Your brain is running on coffee fumes and you have exactly 47 seconds to push a fix.

This would not be the ideal time to look up the exact git command syntax.

It's a good thing you've set up an alias for this precise situation:

`quickfix` runs `git pull --rebase && git add . && git commit -m 'Quick fix' && git push` in one command. Three seconds, and your work is shipped.

When your cognitive load is already maxed out on keeping tiny humans alive, every saved keystroke matters.

## Why Aliases Matter More for Parent Developers

Typically, developers optimize for readability and best practices. Parent developers benefit from optimizing for **speed and resumability**. When your coding windows are measured in minutes and you have precious few more of those than functioning brain cells, every saved keystroke compounds.

The math is simple:
- Average parent coding session: 15 minutes
- Time spent on repetitive commands: 2-3 minutes
- Time saved with good aliases: 2-3 minutes
- **Productivity increase: 15-20%**

More importantly, aliases reduce **cognitive load**. When you're tired and distracted, muscle memory beats trying to remember command syntax.

## The Parent Developer Aliases for Every Situation

I've organized these by the scenarios that actually happen in parent developer life! You can copy and paste these right into your `.zshrc` or `.bashrc`.

### 1. Emergency Git Workflows

These are for when things break and you need to act fast:

```bash
# The golden trio - save your work instantly
alias save="git add . && git commit -m 'WIP: interrupted by life' && git push"
alias quickfix="git pull --rebase && git add . && git commit -m 'Quick fix' && git push"
alias backup="git add . && git commit -m 'Backup before trying something' && git push"

# When you return and can't remember what you were doing
alias last="git log --oneline -5"
alias status="git status && echo '---' && git log --oneline -3"
alias changes="git diff HEAD~1"

# Quick branch management
alias main="git checkout main && git pull"
alias newbranch="git checkout -b"
alias deletebranch="git branch -d"

# When you need to abandon ship quickly
alias abort="git reset --hard HEAD && git clean -fd"
alias unstage="git reset HEAD ."
```

**Real scenario:** Production is broken, your kid is waking up, but you've found the fix. Use `backup` to save current state, change that `==` to a `===` (or is it a missing semicolon again?), `quickfix` to deploy, then go handle parenting. If it doesn't work, `abort` gets you back to safety.

### 2. Quick Project Switching

Parent developers juggle multiple projects in small time windows:

```bash
# Navigate to common project directories
alias work="cd ~/work && ls"
alias personal="cd ~/personal-projects && ls"
alias blog="cd ~/blog && code . && hugo server -D"
alias family="cd ~/family-projects && ls"

# Quick environment setup
alias devup="docker-compose up -d && npm run dev"
alias devdown="docker-compose down && pkill -f 'node'"
alias fresh="rm -rf node_modules && npm install && npm run dev"

# Open common project combinations
alias workday="code ~/work/current-project && cd ~/work/current-project"
alias blogpost="cd ~/blog && hugo new content/posts/$(date +%Y-%m-%d)- && code ."
```

**Parent-specific benefit:** No time wasted navigating directories or remembering startup commands. `blog` opens your editor and starts the dev server in one command.

### 3. Development Environment Shortcuts

When you have 15 minutes to code, environment setup can't take 5 of them:

```bash
# Server management
alias serve="python -m http.server 8000"
alias nodeserve="npx serve -s build -l 3000"
alias hugoserve="hugo server -D --bind 0.0.0.0 --port 1313"

# Testing shortcuts
alias test="npm test"
alias testwatch="npm test -- --watch"
alias testcoverage="npm test -- --coverage"

# Package management
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nrun="npm run"

# Quick file operations
alias ll="ls -la"
alias la="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Process management
alias ports="lsof -i -P -n | grep LISTEN"
alias killnode="pkill -f node"
alias killport="function _killport(){ lsof -ti:$1 | xargs kill -9; }; _killport"
```

### 4. Family Automation Helpers

These aren't strictly development, but they save time for coding:

```bash
# Quick system checks
alias diskspace="df -h | grep -E '^/dev/' | awk '{print \$5 \" \" \$6}' | sort -rn"
alias memcheck="free -h"
alias cpucheck="top -bn1 | grep 'Cpu(s)' | awk '{print \$2}' | cut -d'%' -f1"

# Family computer management
alias updateall="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias cleanup="sudo apt autoremove -y && sudo apt autoclean"
alias fixwifi="sudo systemctl restart NetworkManager"
```

### 5. Content Creation Workflows

For when you're building in public (like writing this blog):

```bash
# Blog post management
alias newpost="hugo new content/posts/$(date +%Y-%m-%d)-"
alias preview="hugo server -D --bind 0.0.0.0"
alias publish="git add . && git commit -m 'New post' && git push"

# Quick content ideas capture to a file
alias idea="echo '$(date +%Y-%m-%d): ' >> ~/content-ideas.md && code ~/content-ideas.md"
alias ideas="code ~/content-ideas.md"
```

## Installation Guide for Busy Parents

### Step 1: Back Up Your Current Setup
```bash
# Always backup first - parent developers can't afford to break their environment
cp ~/.bashrc ~/.bashrc.backup
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || echo "No zsh config found"
```

### Step 2: Add Aliases Gradually

You may not want to add everything at once. Start with the aliases that seem most useful to you to start with, then build on your new workflow gradually.

### Step 3: Test Safely

Before relying on aliases in a high-pressure end-of-nap scenario, try them out (late at night after everyone is guaranteed to be asleep… I hope).

### Step 4: Add More Over Time

As you get comfortable, add the categories that matter most to your workflow. I recommend this order:
1. Emergency git workflows
2. Project switching
3. Development environment shortcuts
4. Family automation helpers
5. Content creation workflows

## Advanced Parent Developer Aliases

Once you're comfortable with the basics, these power-user aliases can save even more time:

### Git Superpowers
```bash
# One-command pull request workflow
alias pr="git push && gh pr create --fill"

# Quick conflict resolution
alias conflicts="git diff --name-only --diff-filter=U"
alias resolve="git add . && git commit -m 'Resolve conflicts'"

# Branch cleanup
alias cleanup-branches="git branch --merged | grep -v main | xargs -n 1 git branch -d"
```

### Project Templates
```bash
# Start new projects instantly
alias new-react="npx create-react-app"
alias new-hugo="hugo new site"
alias new-node="mkdir -p new-project && cd new-project && npm init -y"
```

### Multi-Project Management
```bash
# Update all your projects at once
alias update-all-repos="find ~/projects -name '.git' -type d -execdir git pull \;"
alias status-all-repos="find ~/projects -name '.git' -type d -execdir git status -s \;"
```

## Making Aliases Stick

### 1. Start Small
Pick 3-5 aliases that solve your most frequent pain points. Master those before adding more.

### 2. Use Muscle Memory
The best aliases feel natural to type. `save` works because it's obvious. `qf` for quickfix might be faster, but you'll forget it.

### 3. Document Your Aliases
Keep a cheat sheet until they become automatic:
```bash
# List all your custom aliases
alias
```

## Troubleshooting Common Issues

### "Command not found" Errors
```bash
# Check if aliases are loaded
alias save
# If empty, your shell config isn't being sourced

# Make sure you're editing the right file
echo $SHELL  # Shows /bin/bash or /bin/zsh
```

### Aliases Not Persisting
```bash
# For bash users
echo "source ~/.bashrc" >> ~/.bash_profile

# For zsh users
echo "source ~/.zshrc" >> ~/.zprofile
```

### Git Aliases Conflicting
```bash
# Check existing git aliases
git config --list | grep alias

# Remove conflicts
git config --global --unset alias.save
```

## The Compound Effect

Here's what really matters: these aliases don't just save individual seconds—they **reduce context switching overhead**.

When you can execute complex workflows in single commands, you spend more mental energy on actual problem-solving instead of remembering syntax.

After using these aliases for a month, my typical 15-minute coding session breaks down like this:
- **30 seconds:** Environment setup (down from 3 minutes)
- **14 minutes:** Actual coding and problem-solving
- **30 seconds:** Save and cleanup

That's a **20% increase in actual coding time**, which compounds over weeks and months.

## What's Next

These aliases handle the command-line productivity side, but parent developers need more than just faster typing. In my next post, I'll cover **CLI tools and workflows designed specifically for 15-minute coding windows**—including AI-assisted context recovery, project state management, and emergency deployment strategies.

The goal isn't just to type faster—it's to **think faster** and **recover context instantly** when your coding time is fragmented.

**Download:** Want all these aliases in one file? I've created a [ready-to-install bash aliases collection](https://gist.github.com/raisingpixels/a78214f60a639df31343104e7d6d1017) that you can source directly into your shell configuration.
