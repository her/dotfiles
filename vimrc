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

call plug#end()

set nu
set rnu
set hlsearch
set tw=80
set mouse=a
set t_Co=256
set path+=**
set wildmenu
set expandtab
set smartindent
set incsearch
set smartcase
set ignorecase
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shell=bash
set laststatus=2
set timeoutlen=1000
set ttimeoutlen=0
set encoding=utf8
set updatetime=100
set background=dark
set pastetoggle=<F3>
set backspace=indent,eol,start
nnoremap <bs> <c-w>W
nnoremap <Tab> <c-w>w
nnoremap <silent> <CR> :nohlsearch<CR><CR>
syntax on
syntax enable
filetype plugin on
filetype plugin indent on
hi LineNr ctermfg=244
hi CursorLineNr ctermbg=234 ctermfg=169
au FileType * set cole=0
au VimEnter * RainbowParentheses 
au BufRead, BufNewFile *.md *.ghmarkdown setlocal textwidth=80

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ }
      \ }
function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction
function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "🔒"
  else
    return ""
  endif
endfunction
function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

" VimCompletesMe
setlocal complete+=k/usr/share/dict/words
autocmd FileType text,markdown let b:vcm_tab_complete = 'dict' 
autocmd FileType ruby let b:vcm_tab_complete = "omni"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ale
let g:ale_sign_column_always = 0
let g:ale_sign_error = "🔸"
let g:ale_sign_warning = "🔹"
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" indentline
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" rainbow parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" vim-jsx
let g:jsx_ext_required = 1

" netrw
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" Ruby stuff 
abbr pry require 'pry'; binding.pry
