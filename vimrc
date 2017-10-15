if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ajh17/VimCompletesMe'
Plug 'w0rp/ale'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'unblevable/quick-scope'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'her/central.vim'
Plug 'gerw/vim-HiLinkTrace'
Plug 'tpope/vim-fugitive'
Plug 'shime/vim-livedown'
Plug 'fatih/vim-go'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme enlighten

set number
set autoindent
set smartindent
set relativenumber
set textwidth=80
set backspace=indent,eol,start

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set splitright
set t_Co=16
set mouse=a
set shell=bash
set encoding=utf8

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

set laststatus=2
set statusline=
set statusline+=%#Normal#                      " highlight
set statusline+=%{mode()}                      " mode
set statusline+=\ \|                           " seperator
set statusline+=\ %{fugitive#head()}           " git
set statusline+=\ \|                           " seperator
set statusline+=\ %F                           " filepath
set statusline+=\ \|                           " seperator
set statusline+=\ %t                           " filename
set statusline+=\ %m                           " modified
set statusline+=%h                             " helpfile
set statusline+=%r                             " read only
set statusline+=%=                             " left/right separator
set statusline+=%{strlen(&fenc)?&fenc:'none'}  " file encoding
set statusline+=\ %{&ff}                       " file format
set statusline+=\ %Y                           " filetype
set statusline+=\ \|                           " separator
set statusline+=\ %l:%c                        " line/column
set statusline+=\ %p%%                         " percent through file
set statusline+=\ \|                           " separator
set statusline+=\ %{getcwd()}                  " cwd

set pastetoggle=<F3>
nnoremap <bs> <c-w>W
nnoremap <Tab> <c-w>w
nnoremap <S-Right> :tabnext<CR>
nnoremap <S-Left> :tabprevious<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>

autocmd FileType netrw setlocal bufhidden=delete
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType help wincmd L

" VimCompletesMe
setlocal complete+=k/usr/share/dict/words
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd FileType ruby,python let b:vcm_tab_complete = "omni"
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

" ale
let g:ale_fixers = {}
let g:ale_sign_error = "🔸"
let g:ale_sign_warning = "🔹"
let g:ale_sign_column_always = 0
let g:ale_fixers.javascript = ['eslint']
let g:ale_javascript_eslint_executable = '.eslintrc.js'
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" vim-jsx
let g:jsx_ext_required = 1

" rainbow parentheses
let g:rainbow#max_level = 15
let g:rainbow#blacklist = range(15, 255)
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd VimEnter * RainbowParentheses 

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" vim-livedown
let g:livedown_autorun = 1

" Ruby stuff
abbr pry require 'pry'; binding.pry
" stops ruby from being slow :( 
set ttyfast
set lazyredraw
set re=1
