# dotfiles 💎

Contains various dotfiles and configuration files for MacOS

## Dependencies

### vim-plug

If you've cloned this repo to a new host be sure to grab vim.plug and drop it in
~/.vim/autoload 

```shell
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux

* **MacOS Pastboard** - Access MacOS pasteboard in tmux sessions. Install with `brew install reattach-to-user-namesapce` [more info](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

## Notes

* **Install** - `.install.sh` A simple bash script that symlinks dotfiles to `~/` and moves replaced dotfiles to dotfiles-old for easy deletion
