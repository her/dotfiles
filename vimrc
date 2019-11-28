" These are the driving requirements of this RC file.
"
" 1) Fuzzy file finding (open any project file quickly if you know the name)
" 2) File Switching (see and quick switch open files, fuzzy or tree browse)
" 3) Linting (automatic and fast, can use code fixer)
" 4) Projet Searching (arbitrary string, symbol, definitions, usages of symbol)
" 5) Intelligent code completion (autocompletion, reflection, docs)
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'arzg/vim-sh'
Plug 'fatih/vim-go'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

Plug 'her/central.vim'
Plug 'her/enlighten'

Plug 'psliwka/vim-smoothie'
call plug#end()

set list
set listchars=tab:>-,trail:-,nbsp:%

set breakindent
set showbreak=\|\ \ \ \ 

set laststatus=2
set fillchars=stl:-,stlnc:^
set statusline=\%#Directory#%{fugitive#head()}%#LineNr#\ %{&modified?'[+]':''}%{&readonly?'RO':''}\ [%t]%=%{coc#status()}\ %{get(b:,'coc_current_function','')}%<\[Buf:%n]\ %Y\ %l,%c\ %p%%
set tabline=%!SimpleTabline()
set statusline+=%{gutentags#statusline()}

colorscheme enlighten

set showcmd
set autoindent
set textwidth=100
set synmaxcol=300
set backspace=indent,eol,start

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set encoding=utf8
set foldmethod=manual
set mouse=a
set shell=bash
set ttimeoutlen=0
set updatetime=300

set signcolumn=yes
set shortmess+=c
set cmdheight=2
set hidden

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase
set path+=**
set cscopetag
set tags=./tags,tags;$HOME

nmap <silent> <CR> :nohlsearch<CR>

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"nmap <Tab> <c-w>w
"nmap <Leader>f :%!python -m json.tool<CR>
nmap <Space> <Leader>
nmap <Leader>n :bnext<CR>
nmap <Leader>p :bprevious<CR>

nmap <Leader>f :Files<CR>
nmap <leader>/ :BLines<CR>
nmap <Leader>\ :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :Rg |
nmap <leader>c :Commands<CR>

autocmd FilterWritePre * if &diff | setlocal wrap< | endif
autocmd FileType json syntax match Comment +\/\/.\+$+  " Highlight JSON // Comments
autocmd FileType markdown syntax match markdownError "\w\@<=\w\@="

augroup Go | au! FileType go set nolist | augroup END
augroup C | au! FileType c setlocal sw=4 ts=4 sts=4 et | augroup END
augroup Netrw | au! FileType netrw setlocal bufhidden=delete | augroup END
augroup Markdown | au! BufNewFile,BufReadPost *.md set filetype=markdown | augroup END

augroup Ruby
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
augroup END

augroup Python
  autocmd FileType python setlocal sw=4 ts=4 sts=4 et
  autocmd Filetype python abbreviate <buffer> pdb import pdb; pdb.set_trace()
augroup END

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_files_options='--preview-window down:70% --preview "bat --style=numbers --color=always {}"'

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f -p %s; fd -t f -E %s', base, base)
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

let g:coc_global_extensions=['coc-pairs', 'coc-json', 'coc-solargraph', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-css', 'coc-python']

let g:python_highlight_all=1

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", "vendor", ".git", "*.vim/bundle/*"]

let g:netrw_liststyle = 3

" TODO Optionally include this as a debug setting in enlighten
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" TODO Make this a plugin
function SimpleTabline()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by TabTitle()
    let s .= ' %{TabTitle(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function TabTitle(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  "return bufname(buflist[winnr - 1])
  return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
