# Apple /usr/libexec/path_helper | man path_helper
# https://opensource.apple.com/source/shell_cmds/shell_cmds-162/path_helper/path_helper.c
# Set a default path here
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Command Line Tools, Languages, Binaries, Scipts
PATH=$PATH:$HOME/.rbenv/shims
PATH=$PATH:/usr/local/opt/redis@3.2/bin
PATH=$PATH:/usr/local/opt/postgresql@9.6/bin
PATH=$PATH:$HOME/Library/Python/3.6/bin # aws cli tool

# Change PS1 if SHLVL is greater than 1
LVL=$SHLVL
if [ $LVL -eq 1 ]; then
  PS1="\[$(tput bold)\]"
  PS1+="\w $ "
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

export GREP_OPTIONS="--color=auto --exclude=tags --exclude-dir=.git --exclude-dir=node_modules" # grep

# git
if [ -f $HOME/.git-completion.bash ]; then
  . $HOME/.git-completion.bash
fi

# Python3 (homebrew)
alias setup="python3 -m venv .env_venv"
alias activate="source .env_venv/bin/activate"
alias unittest="python -m unittest"

# aws-cli
complete -C aws_completer aws
# aws-creds script
# usage: aws-creds [MFA] [OPTIONS...]
if [ -f $HOME/.aws-creds.sh ]; then
  . $HOME/.aws-creds.sh
fi

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

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxhghdabagacad

# logbook
function lb() {
  vim ~/work/logbook/$1$(date '+%Y-%m-%d').md
}

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
