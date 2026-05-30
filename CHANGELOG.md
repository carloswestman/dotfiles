# Changelog

## Unreleased

### Changed
- Replaced Agnoster (Oh My Zsh theme) with Starship prompt on macOS and Ubuntu
- `terminal_setup.sh` now installs Starship and symlinks `shared/starship.toml` to `~/.config/starship.toml`
- `terminal_setup.sh` now installs Neovim + LazyVim deps (ripgrep, fd, lazygit on macOS) and symlinks `shared/nvim/` to `~/.config/nvim`
- Ubuntu: Neovim is pulled from the official `ppa:neovim-ppa/stable` PPA (apt ships older versions incompatible with LazyVim)

### Added
- `shared/starship.toml` — cross-platform Starship config with kubernetes, AWS, GCP, and terraform modules enabled
- Catppuccin Mocha palette in `shared/starship.toml` for consistent colors across terminals
- `shared/nvim/` — LazyVim starter vendored into the repo; `lazy-lock.json` tracked for reproducible plugin versions
- `shared/nvim/lua/plugins/colorscheme.lua` — sets `catppuccin-mocha` as the default LazyVim colorscheme
- `shared/nvim/lua/plugins/dashboard.lua` — disables the LazyVim startup dashboard (opens straight to empty buffer)
- `*.swp` / `*.swo` / `*~` ignored in `.gitignore` (vim swap files)

### Tweaked
- Starship: hid `docker_context` (always shows OrbStack — noise) and trimmed AWS module to show profile only (no region) and only when `AWS_PROFILE` is set

## 2.0.0 - 2026-03-31

### Changed
- Restructured repo into `shared/`, `macos/`, and `ubuntu/` directories
- Moved macOS-specific scripts and dotfiles to `macos/`
- Moved cross-platform configs (`.tmux.conf`, tmux scripts) to `shared/`
- Updated `terminal_setup.sh` to symlink from new directory structure
- Rewrote `README.md` for multi-platform usage

### Added
- Ubuntu support: `.zshrc`, `.zprofile`, and all setup scripts using apt
- `ubuntu/terminal_setup.sh` — Zsh, Oh My Zsh, plugins, tmux via apt
- `ubuntu/github_setup.sh` — GitHub CLI, Git config, SSH key (xclip instead of pbcopy)
- `ubuntu/aws_setup.sh` — AWS CLI via apt
- `ubuntu/gcp_setup.sh` — Google Cloud SDK via apt with official repo
- `ubuntu/terraform_setup.sh` — Terraform via tfenv (git clone)

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
