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

# 4️⃣ Install Nerd Font (Hack)
brew install --cask font-hack-nerd-font

echo "Please set your terminal font to Hack Nerd Font in iTerm2/Terminal"

# 5️⃣ tmux installation
brew install tmux

# 6️⃣ Symlink config files from repo to home directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Back up existing files (only if they are real files, not already symlinks)
for file in .zshrc .zprofile; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        cp "$HOME/$file" "$HOME/${file}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backed up ~/$file"
    fi
    ln -sf "$SCRIPT_DIR/$file" "$HOME/$file"
    echo "Symlinked ~/$file -> $SCRIPT_DIR/$file"
done

for file in .tmux.conf; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        cp "$HOME/$file" "$HOME/${file}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backed up ~/$file"
    fi
    ln -sf "$REPO_DIR/shared/$file" "$HOME/$file"
    echo "Symlinked ~/$file -> $REPO_DIR/shared/$file"
done

# ✅ Finished
echo "Terminal setup script finished! Reload Zsh with: source ~/.zshrc"
echo "Start a new tmux session with: tmux new -s dev"
