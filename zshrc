[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PS1="%10F%m%f:%11F%1~%f \$ "

bindkey -e
setopt BASH_AUTO_LIST
setopt noautomenu
setopt nomenucomplete

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# brew install zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

set ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# brew install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
