if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'ajh17/VimCompletesMe'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'her/central.vim'
call plug#end()

set list
set listchars=tab:>-,trail:-,nbsp:%
set showbreak=>\
set laststatus=2
set fillchars=stl:-,stlnc:-
set statusline=\%#Directory#%{fugitive#head()}%#LineNr#\ %{&modified?'[+]':''}%{&readonly?'RO':''}\ [%t]%=%<\[Buf:%n]\ %Y\ %l:%c\ %p%%

set autoindent
set textwidth=80
set backspace=indent,eol,start

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set splitright
set splitbelow
set showcmd
set mouse=a
set shell=bash
set encoding=utf8
set foldmethod=manual

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase
set path+=**
set tags=./tags,tags;

set ttimeoutlen=0
set updatetime=100
set timeoutlen=1000

nmap <Tab> <c-w>w
nmap <silent> <CR> :nohlsearch<CR>
nmap <Space> <Leader>
nmap <Leader>n :bnext<CR>
nmap <Leader>p :bprevious<CR>
nmap <silent> <Leader>; :ls<CR>

autocmd FileType help wincmd L
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

augroup Go | au! FileType go set nolist | augroup END
augroup C | au! FileType c setlocal sw=4 ts=4 sts=4 et | augroup END
augroup Netrw | au! FileType netrw setlocal bufhidden=delete | augroup END
augroup Python | au! FileType python setlocal sw=4 ts=4 sts=4 et | augroup END
augroup Markdown | au! BufNewFile,BufReadPost *.md set filetype=markdown | augroup END

augroup Ruby
  autocmd!
  autocmd FileType ruby setlocal complete-=i
  autocmd FileType ruby setlocal synmaxcol=300
  autocmd FileType ruby setlocal regexpengine=1
  autocmd FileType ruby setlocal norelativenumber
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
augroup END
