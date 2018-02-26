# Source .bashrc from .bash_profile to share configuration across login and sub shells
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi
