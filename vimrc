if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'her/central.vim'
Plug 'tmsvg/pear-tree'
Plug 'vim-python/python-syntax'
Plug 'arzg/vim-sh'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'
call plug#end()

set list
set listchars=tab:>-,trail:-,nbsp:%
set showbreak=>\

set breakindent
set laststatus=2
set fillchars=stl:-,stlnc:-
set statusline=\%#Directory#%{fugitive#head()}%#LineNr#\ %{&modified?'[+]':''}%{&readonly?'RO':''}\ [%t]%=%<\[Buf:%n]\ %Y\ %l:%c\ %p%%

"set background=light
set autoindent
set textwidth=100
set backspace=indent,eol,start

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set showcmd
set mouse=a
set shell=bash
set encoding=utf8
set foldmethod=manual

set ruler

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase
set path+=**
set cscopetag
set tags=./tags,tags;$HOME

set ttimeoutlen=0 " why
set updatetime=100 " what is this
set timeoutlen=1000 " why

nmap <silent> <CR> :nohlsearch<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"nmap <Tab> <c-w>w
nmap <Space> <Leader>
nmap <Leader>n :bnext<CR>
nmap <Leader>p :bprevious<CR>
"nmap <Leader>f :%!python -m json.tool<CR>
nmap <silent> <Leader>; :ls<CR>

nmap <Leader>f :Files<CR>
nmap <leader>/ :BLines<CR>
nmap <Leader>\ :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :Rg |
nmap <leader>c :Commands<CR>


autocmd FilterWritePre * if &diff | setlocal wrap< | endif

augroup Go | au! FileType go set nolist | augroup END
augroup C | au! FileType c setlocal sw=4 ts=4 sts=4 et | augroup END
augroup Netrw | au! FileType netrw setlocal bufhidden=delete | augroup END
augroup Markdown | au! BufNewFile,BufReadPost *.md set filetype=markdown | augroup END

augroup Ruby
  autocmd!
  autocmd FileType ruby setlocal complete-=i
  autocmd FileType ruby setlocal synmaxcol=300
  autocmd FileType ruby setlocal regexpengine=1
  autocmd FileType ruby setlocal norelativenumber
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
augroup END

augroup Python
  autocmd FileType python setlocal sw=4 ts=4 sts=4 et
  autocmd Filetype python abbreviate <buffer> pdb import pdb; pdb.set_trace()
augroup END

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f -p %s; fd -t f -E %s', base, base)
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

let g:fzf_files_options='--preview-window down:70% --preview "bat --style=numbers --color=always {}"'
let g:fzf_layout = { 'window': 'enew' }

" highlights comments in JSON. Since that's not the spec this is maybe bad.
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:ale_linters = {'python': ['flake8']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_set_highlights = 0

let g:python_highlight_all=1
