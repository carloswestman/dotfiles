#!/bin/bash
# terminal_setup.sh
# Setup script for Ubuntu desktop: Zsh, Oh My Zsh, Agnoster, plugins, tmux

# 1. Install Zsh and tmux
sudo apt update
sudo apt install -y zsh tmux

# 2. Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "Default shell changed to Zsh. Log out and back in for it to take effect."
fi

# 3. Install Oh My Zsh (if not installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# 4. Install Zsh plugins via apt
sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting

# 5. Install Nerd Font (Hack)
sudo apt install -y fonts-hack-ttf

echo "Please set your terminal font to Hack Nerd Font in your terminal preferences."

# 6. Symlink config files from repo to home directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

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

echo "Terminal setup finished! Log out and back in, then: source ~/.zshrc"
echo "Start a new tmux session with: tmux new -s dev"
