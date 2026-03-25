# Terminal Setup

My opinionated dev environment for macOS, shaped by real-world work with Kubernetes, Docker, and cloud infrastructure. These scripts automate the setup so I can get a new machine production-ready fast. Works on both Intel and Apple Silicon Macs.

## What's included

### `terminal_setup.sh`

Idempotent setup script that installs tools and symlinks config files from this repo to your home directory:

- **Homebrew** (package manager)
- **Oh My Zsh** with Agnoster theme
- **Zsh plugins**: autosuggestions, syntax highlighting
- **Hack Nerd Font** (required for Agnoster theme)
- **tmux** with a custom config (`Ctrl+A` prefix, mouse support, status bar)
- **Shell aliases** for kubectl, docker, and ls
- Symlinks `.zshrc` and `.tmux.conf` from this repo (backs up existing files first)

### `.zshrc` / `.zprofile` / `.tmux.conf`

Config files tracked in this repo and symlinked to `~` by the setup script. Edit them here, commit, and every machine stays in sync.

- **`.zshrc`** — interactive shell config (plugins, aliases, prompt). Sources `~/.zshrc.local` for machine-specific settings.
- **`.zprofile`** — login shell config (Homebrew). Sources `~/.secrets` for API keys and tokens.
- **`.tmux.conf`** — tmux config (`Ctrl+A` prefix, mouse support, status bar).

Machine-specific settings go in `~/.zshrc.local`, secrets go in `~/.secrets` — both are sourced automatically and not tracked in git.

### `dev-tmux.sh`

Launches a tmux session with two windows for daily development, each with a terminal pane (left) and Claude Code (right):

- **phid** — `/Users/carlos/code/phidippus`
- **saas** — `/Users/carlos/code/rl2`

### `k8s-tmux.sh`

Launches a tmux session with 3 panes pre-configured for Kubernetes work:

- Pod watcher (`kubectl get pods -w`)
- Ad-hoc command shell
- Logs/monitoring pane

### `github_setup.sh`

Installs GitHub CLI and configures Git + SSH:

- Installs `gh` CLI via Homebrew
- Configures git name, email, and default branch
- Generates an ed25519 SSH key (skips if one already exists)
- Skips key upload if GitHub SSH is already working
- Authenticates the `gh` CLI

### `aws_setup.sh`

Installs and configures the AWS CLI for single-account usage:

- Installs AWS CLI via Homebrew
- Runs `aws configure` to set up credentials and default region
- Verifies connectivity with `aws sts get-caller-identity`

Enables scripting for S3, CloudFront invalidations, and other AWS services.

### `gcp_setup.sh`

Installs and configures the Google Cloud CLI:

- Installs Google Cloud SDK (includes `gcloud`, `bq`, `gsutil`)
- Authenticates via browser login
- Sets your default project
- Adds shell completions to `.zshrc`

### `terraform_setup.sh`

Installs Terraform via **tfenv** (version manager):

- Installs tfenv and the latest Terraform version
- Lets you switch between Terraform versions per project
- Uses your existing AWS/GCP credentials automatically

## Usage

```bash
# Initial setup
chmod +x terminal_setup.sh
./terminal_setup.sh

# After setup, set your terminal font to "Hack Nerd Font" in iTerm2/Terminal preferences

# Launch dev tmux layout (phid + saas with Claude Code)
chmod +x dev-tmux.sh
./dev-tmux.sh

# Launch k8s tmux layout
chmod +x k8s-tmux.sh
./k8s-tmux.sh

# GitHub + cloud & infra tools (run as needed)
chmod +x github_setup.sh aws_setup.sh gcp_setup.sh terraform_setup.sh
./github_setup.sh
./aws_setup.sh
./gcp_setup.sh
./terraform_setup.sh
```

## Optional tools to consider

These aren't included in the setup script to keep things lean, but are worth installing individually if you find yourself needing them:

| Tool | What it does | Install |
|------|-------------|---------|
| **k9s** | Terminal UI for Kubernetes clusters | `brew install k9s` |
| **kubectx + kubens** | Fast context/namespace switching | `brew install kubectx` |
| **stern** | Multi-pod log tailing | `brew install stern` |
| **fzf** | Fuzzy finder for shell history and files | `brew install fzf` |
| **jq** | JSON parsing (great with `kubectl -o json`) | `brew install jq` |
| **bat** | `cat` with syntax highlighting | `brew install bat` |
| **Claude Code** | AI coding assistant in the terminal | `npm install -g @anthropic-ai/claude-code` |
