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
Plug 'gerw/vim-HiLinkTrace'
Plug 'her/enlighten'
Plug 'her/central.vim'
" Languages
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'euclio/vim-markdown-composer', { 'for': 'md' }
Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()

set fillchars=stl:―,stlnc:—,vert:│,fold:۰
set statusline=\ %#Directory#%{fugitive#head()}%#LineNr#\ %{&modified?'+':''}%{&readonly?'🔒\ ':''}\ [%t]%=%<\[Buf:%n]\ %Y\ %l:%c\ %p%%\ 

set number
set autoindent
set relativenumber
set showbreak=↪\ 
set textwidth=80
set backspace=indent,eol,start
set list listchars=tab:⇥\ ,extends:›,precedes:‹,nbsp:~,trail:·,eol:¬

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set splitright
set splitbelow
set showcmd
set t_Co=16
set mouse=a
set shell=bash
set encoding=utf8
set foldmethod=manual

colorscheme enlighten
set laststatus=2

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

map <Space> <Leader>
map <Leader>; :ls<CR>
map <Leader>p :bprevious<CR>
map <Leader>n :bnext<CR>
nnoremap <bs> <c-w>W
nnoremap <Tab> <c-w>w
nnoremap <S-Right> :tabnext<CR>
nnoremap <S-Left> :tabprevious<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>

autocmd FileType help wincmd L
autocmd FileType netrw setlocal bufhidden=delete
autocmd FileType go set nolist
autocmd FileType c,python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

augroup RubySettings
  autocmd!
  autocmd FileType ruby setlocal complete-=i
  autocmd FileType ruby setlocal synmaxcol=300
  autocmd FileType ruby setlocal regexpengine=1
  autocmd FileType ruby setlocal norelativenumber
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
augroup END

" ale
let g:ale_sign_column_always = 0
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_javascript_eslint_executable = '.eslintrc.js'
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
hi link ALEErrorSign Red
hi link ALEWarningSign BrightYellow

"indentline
let g:indentLine_setColors = 0

" vim-jsx
let g:jsx_ext_required = 1

" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
