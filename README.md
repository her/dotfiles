# dotfiles🌲

### vimrc 🖤
Install vim-plug
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### .link.sh 🔗
Symlink dotfiles to `~/`. Delete old symlinks. 

### Git Completion ✨
Enables tab completion for git commands. Grab it with this:

```shell
curl -fLo ~/.git-completion.bash \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
```
Then add this to your `.bash_profile`
```shell
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
```
