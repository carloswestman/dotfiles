# --------------------
# Homebrew (Apple Silicon needs this, harmless on Intel)
# --------------------
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"

# --------------------
# Oh My Zsh + Plugins (prompt is handled by Starship, see bottom of file)
# --------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)

# Source Homebrew-installed plugins before Oh My Zsh
BREW_PREFIX="$(brew --prefix)"
source ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ls='ls -lh'
alias k='kubectl'
alias kgp='kubectl get pods'
alias d='docker'
alias dc='docker-compose'

# Enable color in ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# History & auto-correct
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt correct
setopt append_history

# Source local overrides and secrets (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --------------------
# Starship prompt (must be last)
# --------------------
command -v starship >/dev/null && eval "$(starship init zsh)"
