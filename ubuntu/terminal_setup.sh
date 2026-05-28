#!/bin/bash
# terminal_setup.sh
# Setup script for Ubuntu desktop: Zsh, Oh My Zsh, Starship, plugins, tmux, Neovim (LazyVim)

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

# 5. Install Starship prompt (official install script, not in apt)
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    echo "Starship already installed."
fi

# 6. Install Nerd Font (Hack)
sudo apt install -y fonts-hack-ttf

echo "Please set your terminal font to Hack Nerd Font in your terminal preferences."

# 7. Neovim + LazyVim deps
# LazyVim requires nvim >= 0.9, which is newer than older Ubuntu apt versions,
# so use the official stable PPA to get a recent build.
if ! command -v nvim &> /dev/null; then
    echo "Installing Neovim from official PPA..."
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
else
    echo "Neovim already installed."
fi

# ripgrep + fd for Telescope; lazygit is optional and not in default apt
# (install separately if you want the <leader>gg git UI).
sudo apt install -y ripgrep fd-find

# 8. Symlink config files from repo to home directory
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

# Starship config (lives in ~/.config/starship.toml)
mkdir -p "$HOME/.config"
if [ -f "$HOME/.config/starship.toml" ] && [ ! -L "$HOME/.config/starship.toml" ]; then
    cp "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backed up ~/.config/starship.toml"
fi
ln -sf "$REPO_DIR/shared/starship.toml" "$HOME/.config/starship.toml"
echo "Symlinked ~/.config/starship.toml -> $REPO_DIR/shared/starship.toml"

# Neovim config (lives in ~/.config/nvim, points at the LazyVim starter we vendor)
if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backed up existing ~/.config/nvim"
fi
ln -sfn "$REPO_DIR/shared/nvim" "$HOME/.config/nvim"
echo "Symlinked ~/.config/nvim -> $REPO_DIR/shared/nvim"

echo "Terminal setup finished! Log out and back in, then: source ~/.zshrc"
echo "Start a new tmux session with: tmux new -s dev"
echo "Run 'nvim' once to let LazyVim install its plugins (first run takes ~30s)."
