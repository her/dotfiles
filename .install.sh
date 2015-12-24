#!/bin/bash
##################################
# .install.sh
# ln -s dotfiles to home directory
##################################

##########Variables

dir=/Users/mb/etc/dotfiles         #dotfiles directory  
olddir=/Users/mb/etc/dotfiles_old  #dotfiles backup     
files="                    
         git-prompt.sh
	 git-completion.bash
"

dfiles=" 
	 vimrc
	 gitconfig
	 tmux.conf
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

#clean ~/ and create symlinks for files 

for file in $files; do
  echo "Cleaning old symlinks mv to oldir"
  mv ~/$file ~/etc/dotfiles_old/
  echo "Creating symlinks from dir to home" 
  ln -s ~/etc/dotfiles/$file ~/$file
done

#clean ~/ and create symlinks for hidden files

for dfile in $dfiles; do
  echo "Cleaning old symlinks mv to oldir"
  mv ~/.$dfile ~/etc/dotfiles_old/
  echo "Creating symlinks from dir to home" 
  ln -s ~/etc/dotfiles/$dfile ~/.$dfile
done

