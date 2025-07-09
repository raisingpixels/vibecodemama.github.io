---
title: "Quick Context Switching: CLI Tools for Parents Who Code in 15-Minute Windows"
date: "2025-07-12T03:12:36-05:00"
draft: false
description: "Your aliases save keystrokes, but they can't remember what you were building or why. Here are the two tools that actually made fragmented coding sessions feel manageable."
categories: ["Parenting with Systems", "Developer Productivity"]
tags: ["cli", "productivity", "context-switching", "tmux", "ai-tools", "workflow"]
---

## The Six-Day Gap

You haven't touched this project in six days. Life happened—a sick kid, work deadlines, that birthday party that somehow required three trips to Target. Now you're back at your laptop with 22 minutes before the next interruption.

Your aliases can save keystrokes, but they can't tell you why there's a half-finished function called `addMissingContext()` or what that TODO comment about "ask someone smarter than me tomorrow" was supposed to refer to.

This is where parent developers need more than speed—we need **context recovery systems**.

After trying dozens of productivity tools and workflows, I've found exactly two that actually move the needle for fragmented coding sessions. Not ten tools, not a complex system—just two things that solve the biggest problems parent developers face.

## Tool #1: tmux (Your Persistent Development Environment)

**What tmux is:** Think of tmux as a way to create "workspaces" in your terminal that don't disappear when you close your laptop. It's a terminal multiplexer that lets you run multiple terminal sessions inside a single window, and most importantly, keeps them alive even when you disconnect.

I used to lose 5-7 minutes of every coding session just getting my environment back. Open terminal, navigate to project, start the dev server, open the right files, remember which browser tab had localhost:3000... Instead, tmux changes how you work.

**What tmux actually does:** It keeps your terminal sessions alive even when you close your laptop, restart, or accidentally kill Terminal because your kid was "helping" with the trackpad.

### My tmux Setup

Here's a tmux config that saves your brainpower:

```bash
# ~/.tmux.conf
set -g prefix C-a  # Easier to reach than default C-b
unbind C-b
bind C-a send-prefix

# Mouse support (essential when you're tired)
set -g mouse on

# Show which project you're in
set -g status-left "#[fg=green][#S] "
```

And these three aliases that make tmux feel natural:

```bash
alias twork="tmux attach -t work"
alias tblog="tmux attach -t blog"
alias tfam="tmux attach -t family-projects"
```

**Quick setup:** I've created a [complete tmux setup script](https://raisingpixels.dev/quick-context-switching-cli-tools-for-parents-who-code-in-15-minute-windows/parent-dev-tmux-setup.sh) that installs tmux, adds the configuration, and sets up all the aliases automatically. Just download and run it if you want to skip the manual setup.

### How This Actually Works in Practice

Every project gets its own tmux session. When I start working on my blog, I type `tblog` and boom—I'm back in my development environment exactly where I left off, even if it's been a week.

The first time you create a session for a project:

```bash
# Navigate to your project and create a named session
cd ~/blog
tmux new-session -d -s blog
hugo server -D  # Start your dev server
# Open another terminal window/tab and attach
tmux attach -t blog
```

**The magic moment:** Last Tuesday, my laptop died mid-deploy (I ignored the battery warning because I was "almost done"). After restarting, I typed `tblog` and my terminal environment was exactly as I'd left it. The deploy had even completed successfully in the background.

That's when tmux clicked for me. It's not just about saving time—it's about **confidence**. I can start coding immediately without the anxiety of "did I lose anything important?"

### Setting Up Your Sessions

The key is creating named sessions for your main projects:

```bash
# Create sessions for your main projects
tmux new-session -d -s work
tmux new-session -d -s blog
tmux new-session -d -s family-projects

# Then use the aliases to jump between them
tblog    # Attach to blog session
twork    # Attach to work session
tfam     # Attach to family projects session
```

Each session maintains its own windows, working directories, and running processes. When you're working on your blog, start the Hugo server in one tmux window and keep your editor open in another. Everything stays running even when you close your laptop.

## Tool #2: AI-Powered Context Recovery

The second game-changer is using AI to reconstruct what I was working on. This sounds fancy, but it's actually really simple.

### The "What Was I Doing?" Problem

You know that feeling when you open a project and find code that looks familiar but you can't remember why you wrote it that way? Or when you have three TODO comments that made perfect sense at 11 PM but are gibberish now?

I used to spend 10-15 minutes just reading through my own code, trying to remember what I was thinking. Now I let AI do that detective work for me.

### My Context Recovery Setup

I have one script that gathers all the breadcrumbs from my recent work:

```bash
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
```

Run `context` and then paste the output into Claude (or whatever AI tool you prefer) with a simple question: "Based on this git activity, what was I likely working on? What should I focus on next?"

### Why This Works

The AI can see patterns in my commit messages, file changes, and TODOs that I miss when I'm tired or distracted. It's like having a coworker who's been watching my work and can give me a quick briefing.

### Quick State Capture

The other half of context recovery is **leaving breadcrumbs for future me**. I have this simple alias:

```bash
alias snapshot="echo $(date): >> .project-notes.md && code .project-notes.md"
```

Before I step away from a project, I run `snapshot`  and quickly jot down:
- What I was working on
- What I figured out
- What I need to do next
- Any weird gotchas I discovered

Takes 30 seconds, saves me 15 minutes later.

## How These Two Tools Work Together

The magic happens when tmux and AI context recovery work together. Here's my typical workflow when returning to a project:

1. **`tblog`** - Instantly restore my development environment
2. **`context`** - Get AI summary of recent work
3. **`tail .project-notes.md`** - Read my last manual note
4. **Start coding** - Usually within 2 minutes of sitting down

Compare that to my old workflow:
1. Navigate to project directory
2. Try to remember what servers to start
3. Open files I think I was working on
4. Stare at code trying to remember what I was doing
5. Give up and start something easier
6. Actually start coding maybe 10 minutes later, if at all

The difference is **confidence**. I know I can pick up any project quickly, so I'm more likely to use those short coding windows productively instead of avoiding complex work.

## The Real Impact

The productivity gain is most apparent in **reduced mental overhead**.

Before: "I only have 20 minutes, that's not enough time to make real progress on the authentication refactor."

After: "I have 20 minutes, let me see what I was doing on the auth stuff."

When you're not afraid of the ramp-up time for getting back into context, you can work on bigger, more ambitious projects. My side projects actually get finished instead of being abandoned when life gets busy.

**The compound effect:** Small context-switching improvements turn into the ability to maintain complex, long-term projects across fragmented time. That's huge for parent developers.

## Getting Started

**Start with tmux sessions.** Install tmux, create a session for your main project, and force yourself to use it for a week. It'll feel awkward at first, but the productivity gain is immediate and obvious.

**Add AI context recovery later.** Once tmux is a habit, start using the context script. The combination is where the real magic happens.

Don't try to implement everything at once. I've made that mistake with a dozen different productivity tools and ended up using none of them consistently.

## What's Next

These two tools handle the infrastructure of fragmented development. Combined with the mindset from "Coding with Constant Interruptions" and the speed from "Bash Aliases for Sleep-Deprived Parent Developers," you have a complete system for productive parent developer work.

Your coding time might be fragmented, but your progress doesn't have to be!
