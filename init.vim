set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:python3_host_prog = expand("$HOME/.pyenv/versions/3.7.5/bin/python3.7")
let g:ruby_host_prog = expand("$HOME/.rbenv/versions/2.7.1/bin/neovim-ruby-host")
let g:node_host_prog = expand("$HOME/.nodenv/versions/14.4.0/bin/neovim-node-host")
source ~/.vimrc
