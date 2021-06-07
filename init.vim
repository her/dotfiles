" brew uninstal nvim
" brew install --HEAD nvim
let g:python3_host_prog = expand("$HOME/.pyenv/versions/3.8.6/bin/python3.8")
let g:ruby_host_prog = expand("$HOME/.rbenv/versions/2.7.2/bin/neovim-ruby-host")
let g:node_host_prog = expand("$HOME/.nodenv/versions/14.13.0/bin/neovim-node-host")

call plug#begin()
Plug 'psliwka/vim-smoothie'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'her/enlighten'
call plug#end()

colorscheme enlighten

" make-strings-like-this text objects.
set iskeyword+=\-
set shell=bash
set ttimeoutlen=0
set updatetime=300

set backspace=indent,eol,start
set breakindent
set showbreak=\|\ \ \ \ 
set list
set listchars=tab:>-,trail:-,nbsp:%

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set clipboard+=unnamedplus
set encoding=utf8
set foldmethod=manual
set mouse=a

"set signcolumn=yes
set shortmess+=c
set cmdheight=2
set hidden
set showcmd
set splitright
set synmaxcol=300
set laststatus=2
set fillchars=stl:\ ,stlnc:-

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
EOF


