# Dotfiles

My opinionated dev environment for macOS and Ubuntu, shaped by real-world work with Kubernetes, Docker, and cloud infrastructure. These scripts automate the setup so I can get a new machine production-ready fast.

## Structure

```
dotfiles/
├── shared/           # Cross-platform configs
│   ├── .tmux.conf
│   ├── dev-tmux.sh
│   ├── k8s-tmux.sh
│   └── tmux-help.sh
├── macos/            # macOS-specific (Homebrew-based)
│   ├── .zshrc
│   ├── .zprofile
│   ├── terminal_setup.sh
│   ├── aws_setup.sh
│   ├── gcp_setup.sh
│   ├── terraform_setup.sh
│   └── github_setup.sh
├── ubuntu/           # Ubuntu-specific (apt-based)
│   ├── .zshrc
│   ├── .zprofile
│   ├── terminal_setup.sh
│   ├── aws_setup.sh
│   ├── gcp_setup.sh
│   ├── terraform_setup.sh
│   └── github_setup.sh
```

## Quick start

### macOS

```bash
cd macos
chmod +x *.sh
./terminal_setup.sh       # Zsh, Oh My Zsh, plugins, tmux, symlinks

# Cloud & infra tools (run as needed)
./github_setup.sh
./aws_setup.sh
./gcp_setup.sh
./terraform_setup.sh
```

### Ubuntu

```bash
cd ubuntu
chmod +x *.sh
./terminal_setup.sh       # Zsh, Oh My Zsh, plugins, tmux, symlinks

# Cloud & infra tools (run as needed)
./github_setup.sh
./aws_setup.sh
./gcp_setup.sh
./terraform_setup.sh
```

## What's included

### `terminal_setup.sh`

Idempotent setup script that installs tools and symlinks config files from this repo to your home directory:

- **Zsh** with **Oh My Zsh** and Agnoster theme
- **Zsh plugins**: autosuggestions, syntax highlighting
- **Hack Nerd Font** (required for Agnoster theme)
- **tmux** with a custom config (`Ctrl+A` prefix, mouse support, status bar)
- **Shell aliases** for kubectl, docker, and ls
- Symlinks `.zshrc`, `.zprofile`, and `.tmux.conf` (backs up existing files first)

### Config files

Tracked in this repo and symlinked to `~` by the setup script. Edit them here, commit, and every machine stays in sync.

- **`.zshrc`** — interactive shell config (plugins, aliases, prompt). Sources `~/.zshrc.local` for machine-specific settings.
- **`.zprofile`** — login shell config. Sources `~/.secrets` for API keys and tokens.
- **`.tmux.conf`** — tmux config (`Ctrl+A` prefix, mouse support, status bar). Shared across platforms.

Machine-specific settings go in `~/.zshrc.local`, secrets go in `~/.secrets` — both are sourced automatically and not tracked in git.

### Tmux scripts (shared/)

- **`dev-tmux.sh`** — Launches a tmux session with two windows for daily development
- **`k8s-tmux.sh`** — Launches a tmux session with 3 panes for Kubernetes work
- **`tmux-help.sh`** — Quick reference for tmux keybindings

### Cloud & infra setup scripts

Each script installs the CLI tool and walks through authentication:

- **`github_setup.sh`** — GitHub CLI, Git config, SSH key generation
- **`aws_setup.sh`** — AWS CLI, credentials, connectivity check
- **`gcp_setup.sh`** — Google Cloud SDK, browser auth, shell completions
- **`terraform_setup.sh`** — Terraform via tfenv (version manager)

macOS versions use Homebrew, Ubuntu versions use apt.

## Optional tools

| Tool | What it does | macOS | Ubuntu |
|------|-------------|-------|--------|
| **k9s** | Terminal UI for Kubernetes | `brew install k9s` | `snap install k9s` |
| **kubectx + kubens** | Fast context/namespace switching | `brew install kubectx` | `sudo apt install kubectx` |
| **stern** | Multi-pod log tailing | `brew install stern` | `brew install stern` |
| **fzf** | Fuzzy finder for shell history | `brew install fzf` | `sudo apt install fzf` |
| **jq** | JSON parsing | `brew install jq` | `sudo apt install jq` |
| **bat** | `cat` with syntax highlighting | `brew install bat` | `sudo apt install bat` |
| **Claude Code** | AI coding assistant | `npm install -g @anthropic-ai/claude-code` | `npm install -g @anthropic-ai/claude-code` |
