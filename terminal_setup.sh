#!/bin/bash
# terminal_setup.sh
# Setup script for iMac terminal: Zsh, Oh My Zsh, Agnoster, plugins, tmux

# 1️⃣ Homebrew install (if not installed)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # On Apple Silicon, Homebrew installs to /opt/homebrew and needs to be added to PATH
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed."
fi

# 2️⃣ Install Oh My Zsh (if not installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# 3️⃣ Install Zsh plugins via Homebrew
brew install zsh-autosuggestions zsh-syntax-highlighting

# 4️⃣ Create .zshrc backup
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d%H%M%S)

# 5️⃣ Detect Homebrew prefix (Apple Silicon vs Intel)
BREW_PREFIX="$(brew --prefix)"

# 6️⃣ Configure .zshrc
cat << EOF > ~/.zshrc
# --------------------
# Homebrew (Apple Silicon needs this, harmless on Intel)
# --------------------
eval "\$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"

# --------------------
# Oh My Zsh + Agnoster + Plugins
# --------------------
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
source \$ZSH/oh-my-zsh.sh

# Source Homebrew-installed plugins manually
source ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias d='docker'
alias dc='docker-compose'

# Enable color in ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# History & auto-correct
HISTFILE=\$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt correct
setopt append_history
EOF

echo "Updated ~/.zshrc"

# 7️⃣ Install Nerd Font (Hack)
brew install --cask font-hack-nerd-font

echo "Please set your terminal font to Hack Nerd Font in iTerm2/Terminal"

# 8️⃣ tmux installation
brew install tmux

# 9️⃣ Create .tmux.conf
cat << 'EOF' > ~/.tmux.conf
# --------------------
# tmux config optimized for iTerm2 + Kubernetes/Docker
# --------------------
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Pane navigation
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Split panes
bind | split-window -h
bind - split-window -v

# Enable mouse
set -g mouse on

# Status bar
set -g status-bg colour235
set -g status-fg white
set -g status-left "#[fg=green]#H"
set -g status-right "#[fg=yellow]%Y-%m-%d #[fg=cyan]%H:%M:%S"

# History scrollback
set -g history-limit 10000
EOF

echo "Created ~/.tmux.conf"

# ✅ Finished
echo "Terminal setup script finished! Reload Zsh with: source ~/.zshrc"
echo "Start a new tmux session with: tmux new -s dev"
