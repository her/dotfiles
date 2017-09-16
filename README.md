# dotfiles 💎

### vimrc 🖤
Install vim-plug
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### .link.sh 🔗
Symlink dotfiles to `~/`. Delete old symlinks. 

### Enlighten 👩‍🎨
enlighten.terminal theme found [here](https://github.com/her/enlighten). This is
a light theme that I made and enjoy. After downloading just open it with Terminal.app and it will auto import.

```shell
curl -fLo ~/Downloads/enlighten.terminal \
  https://raw.githubusercontent.com/her/enlighten/master/enlighten.terminal
```

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

### tmux 2.5 🏥
Copying to the clipboard requires the following packages:
* [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
* [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
* [tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

[Read the docs](https://github.com/her/dotfiles/blob/master/docs/tmux_configuration.md) for details on how to configure the above with tmux ❄️ 
