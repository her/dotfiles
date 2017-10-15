PS1="\w "

# History wont record command preceded by a space
HISTCONTROL="ignorespace"

# git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Python3 (homebrew)
export PATH=/usr/local/bin:$PATH

#ruby
eval "$(rbenv init -)"
export PATH=/Users/melanie/.rbenv/shims:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# redis
export PATH="/usr/local/opt/redis@3.2/bin:$PATH"

# Colorized output
alias ls="ls -G"

# Color man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
