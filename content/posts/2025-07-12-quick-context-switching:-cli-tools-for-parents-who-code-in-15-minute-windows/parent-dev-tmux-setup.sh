#!/bin/bash
#
# Parent Developer tmux Setup Script
# From: https://raisingpixels.dev/quick-context-switching-cli-tools-for-parents-who-code-in-15-minute-windows/
#
# This script sets up tmux for parent developers with:
# - tmux installation
# - Parent-friendly configuration
# - Project-specific aliases
# - Example startup script
#
# Usage: curl -sSL https://gist.github.com/raisingpixels/e4d1b21c508606ef9aa6bbbc2daf94a2 | bash
# Or: chmod +x setup-parent-dev-tmux.sh && ./setup-parent-dev-tmux.sh
#

set -e  # Exit on any error

echo "🚀 Setting up tmux for Parent Developers..."
echo ""

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="Windows"
else
    OS="Unknown"
fi

echo "🔍 Detected OS: $OS"

# Detect shell
SHELL_NAME=$(basename "$SHELL")
if [[ "$SHELL_NAME" == "zsh" ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL_NAME" == "bash" ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    echo "⚠️  Unsupported shell: $SHELL_NAME"
    echo "   This script supports bash and zsh. You'll need to manually add aliases."
    SHELL_CONFIG=""
fi

echo "🐚 Detected shell: $SHELL_NAME"
if [[ -n "$SHELL_CONFIG" ]]; then
    echo "📝 Will update: $SHELL_CONFIG"
fi
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install tmux
echo "📦 Installing tmux..."
if command_exists tmux; then
    echo "✅ tmux is already installed ($(tmux -V))"
else
    case $OS in
        "macOS")
            if command_exists brew; then
                echo "🍺 Installing tmux via Homebrew..."
                brew install tmux
            else
                echo "❌ Homebrew not found. Please install Homebrew first:"
                echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
                exit 1
            fi
            ;;
        "Linux")
            if command_exists apt; then
                echo "🐧 Installing tmux via apt..."
                sudo apt update && sudo apt install tmux -y
            elif command_exists yum; then
                echo "🐧 Installing tmux via yum..."
                sudo yum install tmux -y
            elif command_exists pacman; then
                echo "🐧 Installing tmux via pacman..."
                sudo pacman -S tmux --noconfirm
            else
                echo "❌ No supported package manager found (apt/yum/pacman)"
                echo "   Please install tmux manually for your distribution"
                exit 1
            fi
            ;;
        "Windows")
            echo "🪟 For Windows, please install tmux via WSL or use Windows Terminal with multiple tabs"
            echo "   This script is designed for macOS/Linux environments"
            exit 1
            ;;
        *)
            echo "❌ Unsupported operating system: $OS"
            echo "   Please install tmux manually"
            exit 1
            ;;
    esac
fi

# Backup existing tmux config
if [[ -f "$HOME/.tmux.conf" ]]; then
    echo "💾 Backing up existing tmux config..."
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d-%H%M%S)"
    echo "✅ Backup saved as ~/.tmux.conf.backup.$(date +%Y%m%d-%H%M%S)"
fi

# Create tmux configuration
echo "⚙️  Creating tmux configuration..."
cat > "$HOME/.tmux.conf" << 'EOF'
# Parent Developer tmux Configuration
# Optimized for quick project switching and ease of use

# Change prefix from C-b to C-a (easier to reach)
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Quick pane navigation with vim-like keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Mouse support (helpful when you're tired)
set -g mouse on

# Improve colors
set -g default-terminal "screen-256color"

# Status bar configuration
set -g status-left "#[fg=green][#S] "
set -g status-right "#[fg=yellow]%Y-%m-%d %H:%M"
set -g status-left-length 20
set -g status-right-length 40

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Increase scrollback buffer size
set -g history-limit 10000

# Enable activity alerts
setw -g monitor-activity on
set -g visual-activity on

# Split panes with more intuitive keybindings
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Quick session switching
bind-key C-a last-window

# Reload config file
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
EOF

echo "✅ tmux configuration created at ~/.tmux.conf"

# Create scripts directory
SCRIPTS_DIR="$HOME/scripts"
if [[ ! -d "$SCRIPTS_DIR" ]]; then
    echo "📁 Creating scripts directory..."
    mkdir -p "$SCRIPTS_DIR"
fi

# Add aliases to shell config
if [[ -n "$SHELL_CONFIG" ]]; then
    echo "🔗 Adding tmux aliases to $SHELL_CONFIG..."

    # Check if aliases already exist
    if grep -q "# Parent Developer tmux aliases" "$SHELL_CONFIG" 2>/dev/null; then
        echo "⚠️  Aliases already exist in $SHELL_CONFIG, skipping..."
    else
        # Backup shell config
        cp "$SHELL_CONFIG" "${SHELL_CONFIG}.backup.$(date +%Y%m%d-%H%M%S)"

        # Add aliases
        cat >> "$SHELL_CONFIG" << 'EOF'

# Parent Developer tmux aliases
# Quick session switching
alias twork="tmux attach -t work"
alias tblog="tmux attach -t blog"
alias tfam="tmux attach -t family-projects"

# tmux session management
alias tsessions="tmux list-sessions"
alias tnew="tmux new-session -d -s"
alias tkill="tmux kill-session -t"

# Quick project status
alias tstatus="tmux list-sessions 2>/dev/null | wc -l | xargs echo 'Active tmux sessions:'"
EOF

        echo "✅ Aliases added to $SHELL_CONFIG"
        echo "💾 Backup saved as ${SHELL_CONFIG}.backup.$(date +%Y%m%d-%H%M%S)"
    fi
fi

# Create example project session creation function
echo "📝 Creating project setup helper..."
cat > "$SCRIPTS_DIR/create-project-session.sh" << 'EOF'
#!/bin/bash
# Helper script to create new project sessions
# Usage: ./create-project-session.sh <session-name> <project-path>

SESSION_NAME="$1"
PROJECT_PATH="$2"

if [[ -z "$SESSION_NAME" ]] || [[ -z "$PROJECT_PATH" ]]; then
    echo "Usage: $0 <session-name> <project-path>"
    echo "Example: $0 myapp ~/projects/myapp"
    exit 1
fi

if [[ ! -d "$PROJECT_PATH" ]]; then
    echo "❌ Project directory not found: $PROJECT_PATH"
    exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "📝 Session '$SESSION_NAME' already exists, attaching..."
    tmux attach -t "$SESSION_NAME"
    exit 0
fi

echo "🚀 Creating session '$SESSION_NAME' for project at $PROJECT_PATH"

# Create session
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_PATH"

# Setup based on project type
if [[ -f "$PROJECT_PATH/package.json" ]]; then
    echo "📦 Detected Node.js project, starting dev server..."
    tmux send-keys -t "$SESSION_NAME:1" 'npm run dev' Enter
elif [[ -f "$PROJECT_PATH/config.yaml" ]] || [[ -f "$PROJECT_PATH/config.yml" ]]; then
    echo "📝 Detected Hugo site, starting server..."
    tmux send-keys -t "$SESSION_NAME:1" 'hugo server -D' Enter
elif [[ -f "$PROJECT_PATH/manage.py" ]]; then
    echo "🐍 Detected Django project, starting server..."
    tmux send-keys -t "$SESSION_NAME:1" 'python manage.py runserver' Enter
else
    echo "📁 Generic project, opening in current directory..."
fi

# Add editor window
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_PATH"
tmux send-keys -t "$SESSION_NAME:2" 'code .' Enter

# Add terminal window
tmux new-window -t "$SESSION_NAME" -c "$PROJECT_PATH"

# Focus on first window
tmux select-window -t "$SESSION_NAME:1"

echo "✅ Session '$SESSION_NAME' created!"
tmux attach -t "$SESSION_NAME"
EOF

chmod +x "$SCRIPTS_DIR/create-project-session.sh"

echo ""
echo "🎉 tmux setup complete!"
echo ""
echo "📋 What was installed:"
echo "   ✅ tmux (terminal multiplexer)"
echo "   ✅ ~/.tmux.conf (parent-friendly configuration)"
if [[ -n "$SHELL_CONFIG" ]]; then
    echo "   ✅ tmux aliases in $SHELL_CONFIG"
fi
echo "   ✅ ~/scripts/create-project-session.sh (project session helper)"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart your terminal or run: source $SHELL_CONFIG"
echo "   2. Create your first session: tmux new-session -d -s blog"
echo "   3. Try the aliases: tblog, twork, tsessions"
echo "   4. Customize sessions for your projects"
echo ""
echo "💡 Quick tmux cheat sheet:"
echo "   Ctrl+a then d    - Detach from session"
echo "   Ctrl+a then c    - Create new window"
echo "   Ctrl+a then n    - Next window"
echo "   Ctrl+a then p    - Previous window"
echo "   Ctrl+a then |    - Split vertically"
echo "   Ctrl+a then -    - Split horizontally"
echo ""
echo "📚 Learn more: https://raisingpixels.dev/quick-context-switching-cli-tools-for-parents-who-code-in-15-minute-windows/"
echo ""
echo "Happy coding! 👩‍💻👨‍💻"
