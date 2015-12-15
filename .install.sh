#!/bin/bash
##################################
# .install.sh
# ln -s dotfiles to home directory
##################################

##########Variables

dir=/Users/mb/etc/dotfiles         #dotfiles directory  
olddir=/Users/mb/etc/dotfiles_old  #dotfiles backup     
files="                    
         vimrc
"

##########Process

#create dotfiles_old in 'olddir'
echo "Creating dotfiles_old in /etc/dotfiles"
mkdir -p $olddir
echo "...done"

#move to dotfiles dir
echo "Changing to $dir"
cd $dir
echo "...done"

#clean ~/ and create symlinks 

for file in $files; do
  echo "Cleaning old symlinks mv to oldir"
  mv ~/.$file ~/etc/dotfiles_old/
  echo "Creating symlinks from dir to home" 
  ln -s ~/etc/dotfiles/$file ~/.$file
done

