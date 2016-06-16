call plug#begin('~/.vim/plugged') 

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'gorodinskiy/vim-coloresque'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'pangloss/vim-javascript'
Plug 'bigfish/vim-js-context-coloring'
Plug 'helino/vim-json'
Plug 'mxw/vim-jsx'
Plug 'suan/vim-instant-markdown'
Plug 'jaxbot/browserlink.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-emoji'

call plug#end()          

" forces vim to use POSIX shell if using fish
set shell=bash             

" sets 256 term color
set t_Co=256

" text width 80
set tw=80

" enables line numbers
set nu

" set paste mode
set pastetoggle=<F3>

" highlights regex searches
set hlsearch

" Enables syntax highlighting
syntax on

" automatically wrap markdown text
au BufRead, BufNewFile *.md *.markdown *.ghmarkdown setlocal textwidth=80

" configs tab key
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" use backspace and tab to change splits in Normal Mode
nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W

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
let g:syntastic_error_symbol="🚫 "
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

" vim-devicons
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"---------------------------------------- 
" devicons-nerdfonts
"---------------------------------------- 
set encoding=utf8

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
" solarized 
"---------------------------------------- 
syntax enable
set background=dark
colorscheme solarized

"---------------------------------------- 
" rainbow parentheses 
"---------------------------------------- 
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
au VimEnter * RainbowParentheses 

"---------------------------------------- 
" vim-javascript 
"---------------------------------------- 
let g:javascript_enable_domhtmlcss = 1

"---------------------------------------- 
" vim-jsx 
"---------------------------------------- 
let g:jsx_ext_required = 1 

"---------------------------------------- 
" instant-markdown
"---------------------------------------- 
filetype plugin on
let g:instant_markdown_autostart = 0

"---------------------------------------- 
" browserlink 
"---------------------------------------- 
let g:bl_serverpath = "http://127.0.0.1:9001"
let g:bl_pagefiletypes = ["html", "javascript", "css"]

"---------------------------------------- 
" vim-markdown
"---------------------------------------- 
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

"---------------------------------------- 
" vimemoji
"---------------------------------------- 
set completefunc=emoji#complete
