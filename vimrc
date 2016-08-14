call plug#begin('~/.vim/plugged') 

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'gorodinskiy/vim-coloresque'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'mxw/vim-jsx'
Plug 'suan/vim-instant-markdown'

call plug#end()          

set nu
set expandtab
set hlsearch
set tw=80
set t_Co=256
set tabstop=4
set shell=bash             
set shiftwidth=4
set encoding=utf8
set background=dark
set pastetoggle=<F3>
nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W
syntax on
syntax enable
filetype plugin indent on
autocmd BufNewFile,BufRead *.json set ft=javascript
au BufRead, BufNewFile *.md *.ghmarkdown setlocal textwidth=80

"---------------------------------------- 
" syntastic
"---------------------------------------- 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_shell = "/bin/bash"

let g:syntastic_loc_list_height=5

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0    " Don't auto-open linter
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode="passive"
let g:syntastic_enable_signs=1
let g:syntastic_warning_symbol="⚠️ "
let g:syntastic_error_symbol="🚫"
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>    " Use F7 to show linter
nnoremap <F8> :exit<CR>    " Use F8 to close linter

let g:syntastic_markdown_checkers = ['mdl']

let g:syntastic_filetype_map = { 
         \    'mkd': 'markdown', 
         \    'ghmarkdown': 'markdown' }

let g:syntastic_extra_filetypes = [ "markdown", "ghmarkdown" ]

let g:syntastic_html_tidy_ignore_errors = ['<html> proprietary attribute "class"', '<script> proprietary attribute "async"'] 

"---------------------------------------- 
" lightline
"---------------------------------------- 
set laststatus=2    " enables always on lightline
set timeoutlen=50   " no pause when switching modes
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',  
      \   'filename': 'LightLineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat'
      \ }, 
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" }, 
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
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

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "🔒 "
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

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

"---------------------------------------- 
" indentline
"---------------------------------------- 
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239

"---------------------------------------- 
" gitgutter
"---------------------------------------- 
set updatetime=100

"---------------------------------------- 
" rainbow parentheses 
"---------------------------------------- 
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
au VimEnter * RainbowParentheses 

"---------------------------------------- 
" vim-jsx 
"---------------------------------------- 
let g:jsx_ext_required = 1 

"---------------------------------------- 
" instant-markdown
"---------------------------------------- 
filetype plugin on
let g:instant_markdown_autostart = 0
