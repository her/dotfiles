#!/bin/bash

# Create links for configuration files and install certain niceties.

# Initializing variables.
CURL='/usr/bin/curl'
CURLARGS="-f -L"

dir=~/etc/dotfiles

dotfiles="
  vimrc
  curlrc
  gitconfig
  gitignore_global
"

# First check if Xcode command line tools are installed
echo "Checking for Xcode Command Line Tools..."
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
  test -d "${xpath}" && test -x "${xpath}" ; then
  echo "Ok ✅"
  echo

  # Prompt user before running link.sh
  read -p "Setup environment and install Homebrew? y/N " -n 1 -r
  echo

  if [[ $REPLY =~ ^[Yy]$ ]]; then

    # Install Homebrew if not already installed
    if test ! $(which brew); then
      echo
      echo "Installing homebrew...🍻"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      echo
      echo "Homebrew already installed. Skipping... ✅"
    fi

    # Removing and replacing old dotfiles. Creating symbolic links for new dotfiles.
    echo "Removing and replacing old dotfiles. Creating symbolic links for new dotfiles. 💕"
    cd $dir
    cp bash_profile ~/.bash_profile
    for dotfile in $dotfiles; do
      rm ~/.$dotfile
      ln -s ~/etc/dotfiles/$dotfile ~/.$dotfile
    done

    # Download Git Completion if it doesn't exist.
    if [ -e $HOME/.git-completion.bash ]; then
      echo "Git Completion already exists. Skipping... ✅"
    else
      echo
      echo "Downloading Git Completion."
      GCHTTP="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
      $CURL $CURLARGS $GCHTTP > ~/.git-completion.bash
    fi

    # Download enlighten.terminal if we don't have it.
    # This really only works for fresh installs, need a better way to check...
    if grep "enlighten" ~/Library/Preferences/com.apple.Terminal.plist > /dev/null; then
      echo "You're already using enlighten.terminal! Skipping... ✅"
    else
      echo
      echo "Downloading enlighten.terminal to ~/Downloads open with terminal.app to auto import."
      EHTTP="https://raw.githubusercontent.com/her/enlighten/master/terminal/enlighten.terminal"
      $CURL $CURLARGS $EHTTP > ~/Downloads/enlighten.terminal
    fi

    echo
    echo "Finished. 💁🏼"
  else
    echo "Aborted."
  fi
else
  echo "fatal: Xcode command line tools not installed."
  echo "Install Xcode then install tools with: xcode-select --install"
  echo
fi
