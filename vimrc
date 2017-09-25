if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
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
Plug 'suan/vim-instant-markdown'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

call plug#end()

set number
set autoindent
set smartindent
set relativenumber
set textwidth=80
set backspace=indent,eol,start
hi LineNr ctermfg=8
hi CursorLineNr ctermfg=0

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set mouse=a
set shell=bash
set laststatus=2
set encoding=utf8
set background=light

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

set pastetoggle=<F3>
nnoremap <bs> <c-w>W
nnoremap <Tab> <c-w>w
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" lightline
let g:lightline = {
  \ 'colorscheme': 'PaperColor_light',
  \ 'active': {
  \   'left': [ ['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'filepath', 'modified'] ],
  \   'right': [ ['percent', 'cwd'], ['lineinfo'], ['fileformat', 'fileencoding', 'filetype'] ]
  \ },
  \ 'component_function': { 'gitbranch': 'fugitive#head', 'filepath': 'LightLineFilePath', 'cwd': 'getcwd' }
  \ }
function! LightLineFilePath()
  return ('' != expand('%:p') ? expand('%:p') : '[No Name]')
endfunction

" VimCompletesMe
setlocal complete+=k/usr/share/dict/words
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
autocmd FileType ruby let b:vcm_tab_complete = "omni"

" ale
let g:ale_sign_column_always = 0
let g:ale_sign_error = "🔸"
let g:ale_sign_warning = "🔹"
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_javascript_eslint_executable = '.eslintrc.js'

" vim-jsx
let g:jsx_ext_required = 1

" rainbow parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = range(17, 255)
autocmd VimEnter * RainbowParentheses 

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" netrw
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" Ruby stuff
abbr pry require 'pry'; binding.pry
" stops ruby from being slow :( 
set ttyfast
set lazyredraw
set re=1

