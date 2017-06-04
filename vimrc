call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'Townk/vim-autoclose'
Plug 'gorodinskiy/vim-coloresque'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'suan/vim-instant-markdown'

call plug#end()

set nu
set rnu
set hlsearch
set expandtab
set tw=80
set t_Co=256
set tabstop=2
set shell=bash
set laststatus=2
set timeoutlen=50
set shiftwidth=4
set encoding=utf8
set updatetime=100
set background=dark
set pastetoggle=<F3>
set statusline+=%*
set statusline+=%#warningmsg#
set backspace=indent,eol,start
set statusline+=%{SyntasticStatuslineFlag()}
nnoremap <bs> <c-w>W
nnoremap <Tab> <c-w>w
nnoremap <F8> :exit<CR> 
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
syntax on
syntax enable
filetype plugin on
filetype plugin indent on
hi LineNr ctermfg=grey
hi CursorLineNr ctermfg=169 "#d75faf
au FileType * set cole=0
au VimEnter * RainbowParentheses 
au BufRead, BufNewFile *.md *.ghmarkdown setlocal textwidth=80

"
" syntastic
"
let g:syntastic_warning_symbol="⚠️ "
let g:syntastic_error_symbol="❌ "
let g:syntastic_shell = "/bin/bash"
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode="passive"
let g:syntastic_enable_signs=1
let g:syntastic_markdown_checkers = ['mdl']
let g:syntastic_extra_filetypes = [ "markdown", "ghmarkdown" ]
let g:syntastic_html_tidy_ignore_errors = ['<html> proprietary attribute "class"', '<script> proprietary attribute "async"'] 
let g:syntastic_filetype_map = { 
         \    'mkd': 'markdown', 
         \    'ghmarkdown': 'markdown' }

"
" lightline
"
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
    return " 🔒 "
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

"
" indentline
"
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239

"
" rainbow parentheses
"
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"
" vim-jsx
"
let g:jsx_ext_required = 1

"
" instant-markdown
"
let g:instant_markdown_autostart = 0
