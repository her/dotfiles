" nvim 0.5 nightly
" brew uninstal nvim
" brew install --HEAD nvim
" ## Fresh install
" brew install --HEAD neovim # Nightly version
"## Upgrade
" brew upgrade neovim --fetch-HEAD # Sometimes you need to update
let g:python3_host_prog = expand("$HOME/.pyenv/versions/3.9.1/bin/python3.9")
let g:ruby_host_prog = expand("$HOME/.rbenv/versions/3.0.0/bin/neovim-ruby-host")
let g:node_host_prog = expand("$HOME/.nodenv/versions/15.6.0/bin/neovim-node-host")

call plug#begin()
Plug 'psliwka/vim-smoothie'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'her/enlighten'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'rhysd/git-messenger.vim'

"Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'camspiers/snap'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()

" lua <<EOF
"   local snap = require'snap'
"   local file = config.file:with {reverse = true, suffix = "»"}
"   local vimgrep = config.vimgrep:with {limit = 50000}
"   local args = {"--hidden", "--iglob", "!.git/*"}

"   snap.maps {
"     {"<Leader><Leader>", file {producer = "ripgrep.file", args = args}, "files"},
"     {"<Leader>sssss", file {producer = "ripgrep.file", prompt = "CustomPrompt"}},
"     {"<Leader>fg", file {producer = "git.file"}, "git.files"},
"     {"<Leader>fb", file {producer = "vim.buffer"}, "buffers"},
"     {"<Leader>ff", vimgrep {}, "grep"},
"     {"<Leader>fo", file {producer = "vim.oldfile"}, "oldfiles"},
"     {"<Leader>fs", file {args = args, try = {"git.file", "ripgrep.file"}}, "git-with-fallback"},
"     {"<Leader>aaaa", file {combine = {"vim.buffer", "vim.oldfiles"}}}
"   }
" EOF

" lua <<EOF
" local snap = require'snap'
" snap.maps {
"   {"<Leader>f", snap.config.file {producer = "ripgrep.file"}},
"   {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
"   {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
"   {"<Leader>ff", snap.config.vimgrep {}},
" }
" EOF

" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fu <cmd>Telescope grep_string<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>



colorscheme enlighten

" make-strings-like-this text objects.
set iskeyword+=\-
set shell=bash
set ttimeoutlen=0
set updatetime=300

set backspace=indent,eol,start
set breakindent
set showbreak=\|\ \ \ \ 
set list
set listchars=tab:>-,trail:-,nbsp:%

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set clipboard+=unnamedplus
set encoding=utf8
set foldmethod=manual
set mouse=a

"set signcolumn=yes
set shortmess+=c
set cmdheight=2
set hidden
set showcmd
set splitright
set synmaxcol=300
set laststatus=2
set fillchars=stl:\ ,stlnc:-

set hlsearch
set wildmenu
set incsearch
set smartcase
set ignorecase

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- manually install with :TSInstall maintained
  -- faster startup time if this is disabled
  --ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
EOF

nmap <silent> <CR> :nohlsearch<CR>
nmap <Space> <Leader>

let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_custom_colors = v:true
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
nnoremap <silent> <C-s>    :BufferPick<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)


nmap <Leader>f :GFiles<CR>
nmap <leader>/ :BLines<CR>
nmap <Leader>\ :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :Rg |
nmap <leader>c :Commands<CR>
let coc_fzf_preview='right:50%'

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! CopyBufferDir let  @+ = expand('%:p:h')
command! CopyBufferPath let @+ = expand('%:p')
command! CopyBufferFilename let @+ = expand('%:p:t')

augroup Ruby
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
augroup END

