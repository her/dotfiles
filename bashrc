# Grab shell levels and terminal variables to dynamically set PS1
LVL=$SHLVL
TERM=$TERM
if [ $LVL -eq 1 ]; then
  PS1="\[$(tput bold)\]"
  PS1+="\[$(tput setaf 0)\]\w "
  PS1+="\[$(tput setaf 8)\]$ "
  PS1+="\[$(tput sgr0)\]"
  export PS1
elif [ $TERM == "screen" ]; then
  PS1="\[$(tput bold)\]"
  PS1+="${STY} "
  PS1+="${WINDOW} \w $ "
  PS1+="\[$(tput sgr0)\]"
  export PS1
else
  PS1="\[$(tput bold)\]"
  PS1+="\[$(tput setaf 1)\]\w "
  PS1+="\[$(tput setaf 8)\]$ "
  PS1+="\[$(tput sgr0)\]"
  export PS1
fi

# History wont record command preceded by a space
HISTCONTROL="ignorespace"
HISTFILESIZE=1000000
HISTSIZE=1000000

# git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Python3 (homebrew)
export PATH=/usr/local/bin:$PATH
alias activate="source env/bin/activate"

# aws-cli
export PATH=~/Library/Python/3.6/bin:$PATH
complete -C aws_completer aws
# aws-creds script
# usage: aws-creds [MFA] [OPTIONS...]
source /Users/melanie/.aws-creds.sh

#ruby
eval "$(rbenv init -)"
export PATH=/Users/melanie/.rbenv/shims:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# redis
export PATH="/usr/local/opt/redis@3.2/bin:$PATH"

# go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/work/go
export GOBIN=$HOME/work/go/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Colorized output
alias ls="ls -G"

# DynamoDB
alias dynamo="java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb"

# grep
export GREP_OPTIONS="--color=auto --exclude=tags --exclude-dir=.git --exclude-dir=node_modules"

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

# logbook
function lb() {
  vim ~/work/logbook/$1_$(date '+%Y-%m-%d').md
}

export PATH="$HOME/.cargo/bin:$PATH"

# qmake
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

# name the title of your shell window
function title () {
  local pkg=title
  if [[ ! $1 ]]; then
    echo "$pkg: missing required argument: title name" 1>&2
    return 99
  fi
  echo "Window Title renamed to $1"
  echo -n -e "\033]0;$1\007"
}
