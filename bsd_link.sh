#!/usr/local/bin/bash

# Initializing variables.
CURL='/usr/local/bin/curl'
CURLARGS="-f -L"

cp bash_profile $HOME/.bash_profile
cp bashrc $HOME/.bashrc
cp curlrc $HOME/.curlrc
cp gitconfig $HOME/.gitconfig
cp gitignore_global $HOME/.gitignore_global
cp psqlrc $HOME/.psqlrc
cp vimrc $HOME/.vimrc

if [ -e $HOME/.git-completion.bash ]; then
  echo "Git Completion already exists. Skipping..."
else
  echo
  echo "Downloading Git Completion."
  GCHTTP="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
  $CURL $CURLARGS $GCHTTP > $HOME/.git-completion.bash
fi

if [ -x /usr/local/bin/git ]; then
  echo "updated core.excludesfile with gitignore global"
  git config --global core.excludesfile $HOME/.gitignore_global
fi
