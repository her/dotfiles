export PS1="\w $ "

# Apple /usr/libexec/path_helper | man path_helper
# https://opensource.apple.com/source/shell_cmds/shell_cmds-162/path_helper/path_helper.c
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=/usr/local/sbin:$PATH
PATH=/usr/local/opt:$PATH
PATH=$HOME/bin:$PATH

PATH=/usr/local/Cellar/openssl@1.1/1.1.1g/bin:$PATH
PATH=/usr/local/opt/postgresql@9.6/bin:$PATH
PATH=/usr/local/opt/imagemagick@6/bin:$PATH

# Settings
export HISTCONTROL="ignorespace"
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export VISUAL=vim
export EDITOR=nvim
export GREP_OPTIONS="--color=auto"
export BAT_THEME="ansi-light"
export CLICOLOR=1 # needed for LSCOLORS
export LSCOLORS=exfxcxdxbxhghdabagacad # BSD LSCOLORS
#export LSCOLORS=ExGxFxdxCxDxDxhbadExEx # GNU LS_COLORS (equivalent)
export LS_COLORS="di=0;36:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=0;32:*.rpm=0:*.tar=0;31"
export IGNOREEOF=42 # ignore <C-D> 42 times before issuing a logout to the shell (prevents accidental logout)
export FZF_DEFAULT_OPTS=--reverse

# Alias
alias ls="ls -G"
alias vim="nvim"
alias realpath="grealpath"

# macOS Functions
bg_navajo() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {65535, 58339, 47802}"; }
bg_wheat() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {65535, 60395, 50886}"; }
bg_yellow() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {65278, 65278, 58853}"; }
bg_ivory() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {65278, 65278, 62451}"; }
bg_snow() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {61937, 60909, 60909}"; }
bg_white() { osascript -e "tell application \"Terminal\" to set background color of window 1 to {65535, 65535, 65535}"; }
fg_black() { osascript -e "tell application \"Terminal\" to set normal text color of window 1 to {0, 0, 0}"; }
whiteboard() { osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"whiteboard\""; }
ubuntu() { osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"Ubuntu\""; }
tango() { osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"Tango Light\""; }
pencil() { osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"PencilLight\""; }
vops() { ubuntu; ssh vops; whiteboard; }
show() { defaults write com.apple.finder CreateDesktop -bool true; killall Finder; }
hide() { defaults write com.apple.finder CreateDesktop -bool false; killall Finder; }
title () { echo -n -e "\033]0;$1\007"; } # usage: title [name]
notify() { osascript -e "display notification with title \"Terminal\" subtitle \"(TODO: add proc and exit code here)\" sound name \"Sosumi\""; } # find more sounds in /System/Library/Sounds/
fullpath() { defaults write com.apple.finder _FXShowPosixPathInTitle -bool $1; killall Finder; } # Usage: fullpath {bool} - Display full file path in Finder window title bar
theme() { osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'; } # toggles between light or dark mode on macOS
preview() {  qlmanage -p "$@" >& /dev/null; }

# Functions
gsl(){ git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'; }
dc() { docker-compose $@; }
dssh() { docker exec -it $1 /bin/bash; }
dcssh() { if [ -z $1 ]; then docker-compose exec $(basename `pwd`) /bin/bash; else docker-compose exec $1 /bin/bash; fi }
dcl() { if [ -z $1 ]; then docker-compose logs -f $(basename `pwd`); else docker-compose logs -f $1; fi }
de() { docker exec -it $1 /bin/bash; }


kgrep() { kls get pods | grep $1; } # will find pods matching grep match - kgrep extraction
kssh() { kls exec -it $1 /bin/bash; } # eash ssh from pod found in ^ - kcssh my-pod
ppcsv() { sed 's/,/ ,/g' "$@"| column -t -s, | less -S; } # pretty prints a csv using column (note: sed adds a space because column merges empty fields)
is_in_git_repo() { git rev-parse HEAD > /dev/null 2>&1; } # Will return non-zero status if the current directory is not managed by git

# Function exports
export -f preview

# LANG
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
