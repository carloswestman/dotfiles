# --------------------
# Homebrew (works on both Apple Silicon and Intel)
# --------------------
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"

# Source secrets (not tracked in git)
[ -f ~/.secrets ] && source ~/.secrets
