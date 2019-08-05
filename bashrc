# Apple /usr/libexec/path_helper | man path_helper
# https://opensource.apple.com/source/shell_cmds/shell_cmds-162/path_helper/path_helper.c
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:$HOME/.rbenv/shims
PATH=$PATH:$HOME/.pyenv/bin
PATH=$PATH:/usr/local/opt/redis@3.2/bin
PATH=$PATH:/usr/local/opt/postgresql@9.6/bin
PATH=$PATH:$HOME/Library/Python/3.7/bin
PATH=$PATH:/usr/local/opt/imagemagick@6/bin

PS1="\[$(tput bold)\]"
PS1+="\[$(tput setaf 8)\]"
PS1+="\w $ "
PS1+="\[$(tput sgr0)\]"

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
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse"
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

[ -s "$HOME/.git-completion.bash" ] && \. "$HOME/.git-completion.bash"
[ -s "$HOME/.aws-creds.sh" ] && \. "$HOME/.aws-creds.sh" # usage: aws-creds [MFA] [OPTIONS...]
[ -s "$HOME/.fzf.bash" ] && \. "$HOME/.fzf.bash"

gsl(){
  git log --pretty=oneline --abbrev-commit | fzf --preview-window up:25 --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always'
}

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fzf and preview files
prv(){
  fzf --preview-window up:25 --preview '[[ $(file --mime {}) =~ binary ]] &&
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

