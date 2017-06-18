# dotfiles 💎

Contains various dotfiles and configuration files for MacOS

## Dependencies

### vim-plug

Run this command on a new host for easy vimrc bootstrappyness :black_heart:

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Civic.terminal
Terminal.app theme. Launch with Terminal and it will auto import.

### tmux

* **MacOS Pastboard** - Access MacOS pasteboard in tmux sessions. Install with `brew install reattach-to-user-namesapce` [more info](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

## .link.sh

* **`.link.sh` A simple bash script that symlinks dotfiles to `~/` and moves replaced dotfiles to dotfiles-old for easy deletion
