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
Plug 'antoinemadec/coc-fzf'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/goyo.vim'

Plug 'arzg/vim-sh'
Plug 'fatih/vim-go'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'
Plug 'sentientmachine/Pretty-Vim-Python'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'

Plug 'her/central.vim'
Plug 'her/enlighten'
Plug 'her/after'

Plug 'psliwka/vim-smoothie'
call plug#end()

set list
set listchars=tab:>-,trail:-,nbsp:%

set breakindent
set showbreak=\|\ \ \ \ 

set laststatus=2
set fillchars=stl:-,stlnc:^
set statusline=\%#Directory#%{fugitive#head()}%#LineNr#\ %{&modified?'[+]':''}%{&readonly?'RO':''}\ [%t]%=%{coc#status()}\ %{get(b:,'coc_current_function','')}\ %<\[Buf:%n]\ %Y\ %l,%c\ %p%%
set tabline=%!SimpleTabline()
set statusline+=%{gutentags#statusline()}

let g:markdown_fenced_languages = ['ruby']

" :h pythonx
" :call health#coc#check()
" TODO: This is not working for some reason, needs investigating
"set pyxversion=3

let g:coc_status_error_sign = 'E'
let g:coc_status_warning_sign = 'W'

colorscheme enlighten

set showcmd
set autoindent
"set textwidth=100
set synmaxcol=300
set backspace=indent,eol,start

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set clipboard+=unnamedplus
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
set splitright

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase
set path+=**
set cscopetag
set tags=./tags,tags;$HOME

" what about previous?
" nmap <Leader>n :bnext<CR>
" nmap <Leader>p :bprevious<CR>
nmap <silent> <CR> :nohlsearch<CR>

nmap <Space> <Leader>

nmap <S-tab> gt

nmap <Leader>f :Files<CR>
nmap <leader>/ :BLines<CR>
nmap <Leader>\ :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :Rg |
nmap <leader>c :Commands<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent><leader>i <Plug>(coc-diagnostic-info)
nmap <silent><leader>n <Plug>(coc-diagnostic-next)
nmap <silent><leader>p <Plug>(coc-diagnostic-prev)

nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()


"let g:netrw_liststyle = 3
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
  autocmd Filetype python abbreviate <buffer> ipy import IPython; IPython.embed(colors="neutral")
augroup END

let g:python_highlight_all=1

let g:coc_global_extensions=['coc-json',
      \ 'coc-solargraph', 'coc-tsserver', 'coc-eslint',
      \ 'coc-prettier', 'coc-css', 'coc-python']

" coc-fzf
let coc_fzf_preview='down:70%'
let g:fzf_files_options='--preview-window down:70% --preview-window down:wrap --preview "cat {}"'
let g:fzf_layout = { 'window': 'call SearchWindow()' }
let g:fzf_preview_window = 'down:50%'


" TODO Optionally include this as a debug setting in enlighten
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
