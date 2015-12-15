call plug#begin('~/.vim/plugged') 

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-emoji'

call plug#end()          

"Forces vim to use POSIX shell if using fish
set shell=bash             

"Enables line numbers
set nu

"Highlights regex searches
set hlsearch

"Enables syntax highlighting
syntax on

"Automatically wrap markdown text
au BufRead, BufNewFile *.md *.markdown *.ghmarkdown setlocal textwidth=80

"---------------------------------------- 
" syntastic
"---------------------------------------- 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_shell = "/bin/bash"

let g:syntastic_loc_list_height=5

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_markdown_checkers = ['mdl']

let g:syntastic_filetype_map = { 
         \    'mkd': 'markdown', 
         \    'ghmarkdown': 'markdown' }

let g:syntastic_extra_filetypes = [ "markdown", "ghmarkdown" ]

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
"silent! if emoji#available()
"  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
"  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
"  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
"  let g:gitgutter_sign_modified_removed = emoji#for('collision')
"endif

"---------------------------------------- 
" solarized 
"---------------------------------------- 
syntax enable
set background=dark
colorscheme solarized

"---------------------------------------- 
" instant-markdown
"---------------------------------------- 
filetype plugin on
let g:instant_markdown_autostart = 0

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

