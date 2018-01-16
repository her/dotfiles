# dotfiles🌲

### .link.sh 🔗
Links dotfiles to `~/`, downloads git-completion and terminal profile, installs
homebrew.

### vimrc 🖤
Launch vim and vimrc will bootstrap itself.

### Notes 🤔

Monkey Patch vim json syntax file to stop concealment of json quotes.

```
open vim
:e $VIMRUNTIME/syntax/json.vim
:g/if has('conceal')/s//& \&\& 0/
:wq
```
