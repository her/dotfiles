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
Plug 'suan/vim-instant-markdown'

call plug#end()

set nu
set rnu
set hlsearch
set expandtab
set tw=80
set t_Co=256
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shell=bash
set laststatus=2
set timeoutlen=50
set shiftwidth=4
set encoding=utf8
set updatetime=100
set background=dark
set pastetoggle=<F3>
set backspace=indent,eol,start
set statusline+=%*
set statusline+=%#warningmsg#
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

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = "⛔️"
let g:ale_sign_warning = "⚠️ "
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" indentline
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239

" rainbow parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" vim-jsx
let g:jsx_ext_required = 1

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" instant-markdown
let g:instant_markdown_autostart = 0
