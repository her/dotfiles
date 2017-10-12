#!/bin/bash

# Create links for configuration files and install certain niceties.

# Initializing variables.
CURL='/usr/bin/curl'
CURLARGS="-f -L"

dir=~/etc/dotfiles
trash=~/etc/dotfiles_old

dotfiles="
  vimrc
  gitconfig
  gitignore_global
"

# First check if Xcode command line tools are installed
echo "Checking for Xcode Command Line Tools..."
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
  test -d "${xpath}" && test -x "${xpath}" ; then
  echo "Ok"
  echo

  # Prompt user before running link.sh
  read -p "Setup environment and install Homebrew? y/N " -n 1 -r
  echo

  if [[ $REPLY =~ ^[Yy]$ ]]
  then

    # Install Homebrew if not already installed
    if test ! $(which brew); then
      echo
      echo "Installing homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      echo
      echo "Homebrew already installed. Skipping..."
    fi

    # Making a temporary directory to store trash.
    echo
    echo "Making a temporary directory to store trash."
    mkdir -p $trash

    # Changing directory.
    echo "Changing to $dir"
    cd $dir

    # Copy bash profile.
    echo "Adding bash profile."
    cp bash_profile ~/.bash_profile

    # Removing and replacing old dotfiles. Creating symbolic links for new dotfiles.
    echo "Removing and replacing old dotfiles. Creating symbolic links for new dotfiles."
    for dotfile in $dotfiles; do
      mv ~/.$dotfile ~/etc/dotfiles_old/
      ln -s ~/etc/dotfiles/$dotfile ~/.$dotfile
    done

    # Removing the trash.
    echo "Removing trash."
    cd ~/etc
    rm -rf dotfiles_old/

    # Download Git Completion
    echo
    echo "Downloading Git Completion."
    GCHTTP="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
    $CURL $CURLARGS $GCHTTP > ~/.git-completion.bash

    # Download enlighten.terminal
    echo
    echo "Downloading enlighten.terminal to ~/Downloads open with terminal.app to auto import."
    EHTTP="https://raw.githubusercontent.com/her/enlighten/master/terminal/enlighten.terminal"
    $CURL $CURLARGS $EHTTP > ~/Downloads/enlighten.terminal

    echo
    echo "Finished."
  else
    echo "Aborted."
  fi
else
  echo "fatal: Xcode command line tools not installed."
  echo "Install Xcode then install tools with: xcode-select --install"
  echo
fi
