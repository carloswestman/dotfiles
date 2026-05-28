# --------------------
# Oh My Zsh + Plugins (prompt is handled by Starship, see bottom of file)
# --------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)

# Source plugins installed via apt
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ls='ls -lh --color=auto'
alias k='kubectl'
alias kgp='kubectl get pods'
alias d='docker'
alias dc='docker-compose'

# History & auto-correct
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt correct
setopt append_history

# Source local overrides and secrets (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# --------------------
# Starship prompt (must be last)
# --------------------
command -v starship >/dev/null && eval "$(starship init zsh)"
