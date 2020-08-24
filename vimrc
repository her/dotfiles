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

Plug 'voldikss/vim-floaterm'

Plug 'mkitt/tabline.vim'

Plug 'hardcoreplayers/dashboard-nvim'

Plug 'darfink/vim-plist'

Plug 'ruanyl/vim-gh-line'

Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'liuchengxu/vista.vim'

Plug 'rhysd/git-messenger.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'ms-jpq/chadtree', {'branch': 'chad'}

Plug 'arzg/vim-sh'
Plug 'fatih/vim-go'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'chrisbra/Colorizer'


Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-abolish'

Plug 'her/central.vim'
Plug 'her/enlighten'

Plug 'psliwka/vim-smoothie'

Plug 'her/synicons.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set list
set listchars=tab:>-,trail:-,nbsp:%

" make-strings-like-this text objects.
set iskeyword+=\-

set breakindent
set showbreak=\|\ \ \ \ 

set laststatus=2
set fillchars=stl:\ ,stlnc:-
set statusline=\%#StatusLineColor#\ \ %{fugitive#head()}\ \ [%t]\ \ %{&modified?'[+]':''}\ \ %{&readonly?'RO':''}\ \ %=%{coc#status()}\ \ %{get(b:,'coc_current_function','')}\ \ %<\ \ [Buf:%n]\ \ %Y\ \ %l,%c\ \ %p%%
set statusline+=\ \ %{gutentags#statusline()}

colorscheme enlighten

set showcmd
set autoindent
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
"set cscopetag
"set tags=./tags,tags;$HOME
set tags=$HOME/.vim/ctags

" what about previous?
" nmap <Leader>n :bnext<CR>
" nmap <Leader>p :bprevious<CR>
nmap <silent> <CR> :nohlsearch<CR>

nmap <Space> <Leader>

nmap <S-tab> gt
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <Leader>f :GFiles<CR>
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

nnoremap <leader>v <cmd>CHADopen<cr>

noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

command! CopyBufferDir let  @+ = expand('%:p:h')
command! CopyBufferPath let @+ = expand('%:p')
command! CopyBufferFilename let @+ = expand('%:p:t')
command! -nargs=0 Prettier :CocCommand prettier.formatFile

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

augroup Javascript
  autocmd Filetype javascript,javascriptreact imap cll console.log();<Esc>==f(a
  autocmd Filetype javascript,javascriptreact vmap cll yocll<Esc>p
  autocmd Filetype javascript,javascriptreact nmap cll yiwocll<Esc>p 
augroup END

augroup auto_colorize
  autocmd!
  autocmd
        \ BufNewFile,BufRead,BufEnter,BufLeave,WinEnter,WinLeave,WinNew
        \ *.js,*.css,*.scss,*.sass,*.less
        \ ColorHighlight
augroup END

function MyCustomHighlights()
    hi semshiLocal            ctermfg=1   guifg=#ff875f
    hi semshiGlobal           ctermfg=3   guifg=#ffaf00
    hi semshiImported         ctermfg=3   guifg=#ffaf00 cterm=bold gui=bold
    hi semshiParameter        ctermfg=4   guifg=#5fafff
    hi semshiParameterUnused  ctermfg=7   guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree             ctermfg=13  guifg=#ffafd7
    hi semshiBuiltin          ctermfg=5   guifg=#ff5fff
    hi semshiAttribute        ctermfg=2   guifg=#00ffaf
    hi semshiSelf             ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved       ctermfg=8   guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected         ctermfg=11  guifg=#ffffff ctermbg=161 guibg=#d7005f

"     hi semshiErrorSign        ctermfg=9   guifg=#ffffff guibg=#d70000
"     hi semshiErrorChar        ctermfg=9   guifg=#ffffff guibg=#d70000
endfunction

autocmd ColorScheme * call MyCustomHighlights()

let g:semshi#filetypes = ["python"]

" Dashboard
let g:dashboard_default_executive = 'fzf'

let g:sessions_dir = '~/.vim/sessions'
exec 'nnoremap <Leader>ss :mksession! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Make a github link and put it in the clipboard
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

let g:markdown_fenced_languages = ['ruby']

let g:coc_status_error_sign = 'E'
let g:coc_status_warning_sign = 'W'

let g:coc_global_extensions=['coc-json',
      \ 'coc-solargraph', 'coc-tsserver', 'coc-eslint',
      \ 'coc-prettier', 'coc-css', 'coc-python']

let coc_fzf_preview='right:50%'
let g:fzf_files_options='--preview-window right:50% --preview-window down:wrap --preview "cat {}"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = 'right:50%'

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']

" let g:gutentags_trace=1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_add_default_project_roots = 0
let g:gutentags_cache_dir = expand('$HOME/.vim/ctags/')
let g:gutentags_modules=['ctags', 'gtags_cscope']
let g:gutentags_exclude_filetypes = ['gitcommit', 'json']
let g:gutentags_project_root = ['package.json', '.git']
"let g:gutentags_ctags_exclude = ['*.git', '*.svg', '*.hg', '*/tests/*', '*/test/*', 'build', 'dist', '*sites/*/files/*', 'bin', 'node_modules', 'bower_components', 'cache', 'compiled', 'docs', 'example', 'bundle', 'vendor', '*.md', '*-lock.json', '*.lock', '*bundle*.js', '*build*.js', '.*rc*', '*.json', '*.min.*', '*.map', '*.bak', '*.zip', '*.pyc', '*.class', '*.sln', '*.Master', '*.csproj', '*.tmp', '*.csproj.user', '*.cache', '*.pdb', 'tags*', 'cscope.*', '*.css', '*.less', '*.scss', '*.exe', '*.dll', '*.mp3', '*.ogg', '*.flac', '*.swp', '*.swo', '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2', '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx']

" a/access Access (or export) of class members
" i/inherits Inheritance information.
" l/language Language of source file containing tag
" m/implementation Implementation information
" n/line Line number of tag definition
" S/signature Signature of routine (e.g. prototype or parameter list)
let g:gutentags_ctags_extra_args = ['--fields=+ailmnS']
let g:gutentags_plus_nomap = 1

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Calls qlmanage to preview images, text, markdown, etc.
nmap <leader><Space> :call Preview()<CR>
function! Preview()
  let path = expand('%:p')
  let cmd = "preview ".expand(path)
  call system(cmd)
endfunction


" TODO Optionally include this as a debug setting in enlighten
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" TODO: #list_cmd() provides endless priview scroll back in :PFiles, why?
command! -bang -nargs=? -complete=dir PFiles
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': 'right:50%'}, <bang>0)
function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f -p %s; fd -t f -E %s', base, base)
endfunction


command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)


function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
