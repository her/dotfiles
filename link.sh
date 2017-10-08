#!/bin/bash

# Creates symbolic links for miscellaneous configuration files.

# Initializing variables.
CURL='/usr/bin/curl'
CURLARGS="-f -L"

dir=~/etc/dotfiles
trash=~/etc/dotfiles_old

dotfiles="
  vimrc
  gitconfig
"

# Making a temporary directory to store trash.
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
echo "Downloading Git Completion."
GCHTTP="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
$CURL $CURLARGS $GCHTTP > ~/.git-completion.bash

# Download enlighten.terminal 
echo "Downloading enlighten.terminal"
EHTTP="https://raw.githubusercontent.com/her/enlighten/master/enlighten.terminal"
$CURL $CURLARGS $EHTTP > ~/Downloads/enlighten.terminal
echo "Downloaded to ~/Downloads open with terminal.app to auto import"

# Install Homebrew
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else echo "Homebrew already installed."
fi
