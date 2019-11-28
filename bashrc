PS1="\[$(tput bold)\]"
PS1+="\w $ "
PS1+="\[$(tput sgr0)\]"

# Apple /usr/libexec/path_helper | man path_helper
# https://opensource.apple.com/source/shell_cmds/shell_cmds-162/path_helper/path_helper.c
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:$HOME/.rbenv/shims
PATH=$PATH:$HOME/.pyenv/shims
PATH=$PATH:/usr/local/opt/redis@3.2/bin
PATH=$PATH:/usr/local/opt/postgresql@9.6/bin
PATH=$PATH:$HOME/Library/Python/3.7/bin
PATH=$PATH:/usr/local/opt/imagemagick@6/bin
PATH=$PATH:/usr/local/bin/go
export BASH_SILENCE_DEPRECATION_WARNING=1

# C lang
PATH="/usr/local/opt/llvm/bin:$PATH"
export CPATH=$(xcrun --show-sdk-path)/usr/include
# To use the bundled libc++ please add the following LDFLAGS:
#   LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
# For compilers to find llvm you may need to set:
#   export LDFLAGS="-L/usr/local/opt/llvm/lib"
#   export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Languages
export GOPATH=/Users/berkley/work/go
PATH=$PATH:$GOPATH/bin

# System
HISTCONTROL="ignorespace"
HISTFILESIZE=1000000
HISTSIZE=1000000

export VISUAL=vim
export EDITOR=vim
export GREP_OPTIONS="--color=auto"
export CLICOLOR=1 # needed for LSCOLORS
export LSCOLORS=exfxcxdxbxhghdabagacad # BSD LSCOLORS
#export LSCOLORS=ExGxFxdxCxDxDxhbadExEx # GNU LS_COLORS (equivalent)

# Tools
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --color 16"
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export BAT_THEME=OneHalfLight
export JAVA_HOME=$HOME/Library/Application\ Support/bin/elasticsearch-6.7.2/jdk-12.0.2.jdk/Contents/Home
export NVM_DIR="$HOME/.nvm"

alias sfwd="ssh -L 5000:localhost:5000 -L 8080:localhost:8080 $1"
alias setup="python3 -m venv .env_venv"
alias activate="source .env_venv/bin/activate"
alias unittest="python -m unittest"
alias basefg="printf '\e[%sm▒' {30..37} 0; echo"
alias basebg="printf '\e[%sm ' {40..47} 0; echo"
alias elasticsearch="cd /Users/berkley/Library/Application\ Support/bin/elasticsearch-6.7.2/bin && ./elasticsearch && cd -"
alias bat="bat --style='header'"
alias vim="nvim"

[ -s "$HOME/.git-completion.bash" ] && \. "$HOME/.git-completion.bash"
[ -s "$HOME/.aws-creds.sh" ] && \. "$HOME/.aws-creds.sh" # usage: aws-creds [MFA] [OPTIONS...]
[ -s "$HOME/.fzf.bash" ] && \. "$HOME/.fzf.bash"

gsl(){
  git log --pretty=oneline --abbrev-commit | fzf --preview-window down:70% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'
}

fe() {
  local files # set the variables files
  IFS=$'\n' files=($(fd . | fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fzf and preview files
prv(){
  fzf --preview-window down:70% --preview '[[ $(file --mime {}) =~ binary ]] &&
                   echo {} is a binary file ||
                   (bat --style=numbers --color=always {} ||
                    highlight -O ansi -l {} ||
                    coderay {} ||
                    rougify {} ||
                    cat {}) 2> /dev/null | head -500'
}

# pretty prints a csv using column (note: sed adds a space because column merges empty fields)
ppcsv() {
  sed 's/,/ ,/g' "$@"| column -t -s, | less -S
}

# logbook
lb() {
  vim ~/work/logbook/$1$(date '+%Y-%m-%d').md
}

# toggles between light or dark mode on macOS
theme() {
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
}

# convert hex to nearest 0-255 term color
fromhex() {
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d\n' "$(( (r<75?0:(r-35)/40)*6*6 +
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}

# 0-255 term color to hex (html color)
tohex() {
    dec=$(($1%256))   ### input must be a number in range 0-255.
    if [ "$dec" -lt "16" ]; then
        bas=$(( dec%16 ))
        mul=128
        [ "$bas" -eq "7" ] && mul=192
        [ "$bas" -eq "8" ] && bas=7
        [ "$bas" -gt "8" ] && mul=255
        a="$((  (bas&1)    *mul ))"
        b="$(( ((bas&2)>>1)*mul ))"
        c="$(( ((bas&4)>>2)*mul ))"
        printf 'dec= %3s basic= #%02x%02x%02x\n' "$dec" "$a" "$b" "$c"
    elif [ "$dec" -gt 15 ] && [ "$dec" -lt 232 ]; then
        b=$(( (dec-16)%6  )); b=$(( b==0?0: b*40 + 55 ))
        g=$(( (dec-16)/6%6)); g=$(( g==0?0: g*40 + 55 ))
        r=$(( (dec-16)/36 )); r=$(( r==0?0: r*40 + 55 ))
        printf 'dec= %3s color= #%02x%02x%02x\n' "$dec" "$r" "$g" "$b"
    else
        gray=$(( (dec-232)*10+8 ))
        printf 'dec= %3s  gray= #%02x%02x%02x\n' "$dec" "$gray" "$gray" "$gray"
    fi
}

# color {range}
color() {
    for c; do
        printf '\e[48;5;%dm%03d' $c $c
    done
    printf '\e[0m \n'
}

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# option bindings
# bind '"\er": redraw-current-line'
# bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
gt() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  # Pass the list of the tags to fzf-tmux
  # - "{}" in preview option is the placeholder for the highlighted entry
  # - Preview window can display ANSI colors, so we enable --color=always
  # - We can terminate `git show` once we have $LINES lines
  git tag --sort -version:refname |
    fzf-tmux --multi --preview-window right:70% \
             --preview 'git show --color=always {} | head -'$LINES
}

#eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm


dc() { docker-compose $@; }
dssh() { docker exec -it $1 /bin/bash; }
dcssh() { if [ -z $1 ]; then docker-compose exec $(basename `pwd`) /bin/bash; else docker-compose exec $1 /bin/bash; fi }
dcl() { if [ -z $1 ]; then docker-compose logs -f $(basename `pwd`); else docker-compose logs -f $1; fi }

work() { vim $(git ls-tree -r HEAD --name-only); }
[ -r /Users/berkley/.profile_lda ] && . /Users/berkley/.profile_lda

workspace() { cd $GOPATH/src/github.com/her; }

# Git Commands
# removes local branches already merged to master
# git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d
#
# show changes since master
# git log --oneline master..myBranch
#
# changes from tip of master to tip of branch
# git log --oneline master...myBranch
#
# list of changed files
# git diff-tree --no-commit-id --name-only -r <commit>
#
# open all tracked files
# vim $(git ls-tree -r HEAD --name-only | grep -v -i "assets\|migrate\|public")

# postgres
# postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
