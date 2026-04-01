#!/bin/bash
# github_setup.sh
# Install GitHub CLI, configure Git, and set up SSH key on Ubuntu

echo "=== GitHub Setup ==="

# 1. Install GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt update
    sudo apt install -y gh
else
    echo "GitHub CLI already installed: $(gh --version | head -1)"
fi

# 2. Collect user info
echo ""
read -p "Enter your Git name (e.g. Carlos Westman): " GIT_NAME
read -p "Enter your Git email (e.g. you@example.com): " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main

echo "Git configured as: $GIT_NAME <$GIT_EMAIL>"

# 3. Generate SSH key (if none exists)
SSH_KEY="$HOME/.ssh/id_ed25519"

if [ -f "$SSH_KEY" ]; then
    echo ""
    echo "SSH key already exists at $SSH_KEY — skipping generation."
else
    echo ""
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N ""
    echo "SSH key generated at $SSH_KEY"
fi

# 4. Check if GitHub SSH is already working
echo ""
echo "Checking GitHub SSH connection..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"

if [ $? -eq 0 ]; then
    echo "SSH key already added to GitHub — skipping."
else
    # Start ssh-agent and add key
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"

    # Copy public key to clipboard
    if command -v xclip &> /dev/null; then
        xclip -selection clipboard < "${SSH_KEY}.pub"
        echo "Your public key has been copied to the clipboard."
    else
        echo "Install xclip for clipboard support: sudo apt install xclip"
        echo "Your public key:"
        cat "${SSH_KEY}.pub"
    fi
    echo ""
    echo "Next step: Add it to GitHub"
    echo "  1. Go to https://github.com/settings/ssh/new"
    echo "  2. Paste the key and save"
    echo ""
    read -p "Press Enter once you've added the key to GitHub..."
fi

# 5. Authenticate GitHub CLI (if not already logged in)
if gh auth status &> /dev/null; then
    echo ""
    echo "GitHub CLI already authenticated."
else
    echo ""
    echo "Authenticating GitHub CLI..."
    gh auth login
fi

# 6. Verify
echo ""
echo "Verifying SSH connection..."
ssh -T git@github.com

echo ""
echo "GitHub setup complete!"
