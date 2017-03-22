#!/bin/bash

#
# Creates symbolic links for miscellaneous configuration files.
#

# Initializing variables.
dir=/Users/mb/etc/dotfiles   
trash=/Users/mb/etc/dotfiles_old     
files="                    
  git-prompt.sh
  git-completion.bash
"

dotfiles=" 
  vimrc
  gitconfig
  tmux.conf
  bash_profile
"

# Making a temporary directory to store trash.
echo "Making a temporary directory to store trash."
mkdir -p $trash

# Changing directory.
echo "Changing to $dir"
cd $dir

# Removing and replacing old files. Creating symlinks for new files. 
for file in $files; do
  echo "Removing old symbolic links."
  mv ~/$file ~/etc/dotfiles_old/
  echo "Creating symbolic links for new files." 
  ln -s ~/etc/dotfiles/$file ~/$file
done

# Removing and replacing old dotfiles. Creating symlinks for new dotfiles.
for dotfile in $dotfiles; do
  echo "Removing old symbolic links."
  mv ~/.$dotfile ~/etc/dotfiles_old/
  echo "Creating symbolic links for new files." 
  ln -s ~/etc/dotfiles/$dotfile ~/.$dotfile
done

# Removing the trash.
echo "Removing trash."
cd ~/etc
rm -rf dotfiles_old/
