# Changelog

## 1.0.0 - 2026-03-24

### Added
- `terminal_setup.sh` — Idempotent setup: Homebrew, Oh My Zsh, Agnoster theme, zsh plugins, Hack Nerd Font, tmux
- `.zshrc` / `.tmux.conf` — Dotfiles tracked in repo, symlinked to home directory by setup script
- `~/.zshrc.local` sourcing for secrets and machine-specific overrides (not tracked)
- `k8s-tmux.sh` — Pre-configured tmux session with 3 panes for Kubernetes work
- `github_setup.sh` — GitHub CLI, Git config, and SSH key setup with smart skip logic
- `aws_setup.sh` — AWS CLI installation and interactive credential setup
- `gcp_setup.sh` — Google Cloud SDK installation with BigQuery, gsutil, and shell completions
- `terraform_setup.sh` — Terraform via tfenv version manager
- Apple Silicon and Intel Mac support via auto-detected Homebrew paths
- `.gitignore` to prevent accidental credential commits
- `README.md` with usage instructions and optional tool suggestions
