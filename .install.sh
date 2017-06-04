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
"

# Making a temporary directory to store trash.
echo "Making a temporary directory to store trash."
mkdir -p $trash

# Changing directory.
echo "Changing to $dir"
cd $dir

# Removing and replacing old files. Creating symbolic links for new files.
echo "Removing and replacing old files. Creating symbolic links for new files." 
for file in $files; do
  mv ~/$file ~/etc/dotfiles_old/
  ln -s ~/etc/dotfiles/$file ~/$file
done

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
