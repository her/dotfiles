let g:python3_host_prog = expand("$HOME/.pyenv/versions/3.9.1/bin/python3.9")
let g:ruby_host_prog = expand("$HOME/.rbenv/versions/3.0.0/bin/neovim-ruby-host")
let g:node_host_prog = expand("$HOME/.nodenv/versions/15.6.0/bin/neovim-node-host")

call plug#begin()
Plug 'psliwka/vim-smoothie'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'her/enlighten'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'folke/trouble.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'kyazdani42/nvim-tree.lua' " You can toggle the help UI by pressing g?
"Plug 'glepnir/lspsaga.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'antoinemadec/coc-fzf'

Plug 'rhysd/git-messenger.vim'

Plug 'nvim-lua/plenary.nvim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()

luafile ~/.config/nvim/compe-config.lua
luafile ~/.config/nvim/python-ls.lua
luafile $HOME/.config/nvim/ruby-ls.lua
luafile $HOME/.config/nvim/tss-ls.lua

colorscheme enlighten

set statusline=\ \
set statusline=\ %#Separator#%#Contents#%t%#Separator#
set statusline+=\ %#Separator#
set statusline+=%#Modified#%{&modified?'●':''}
set statusline+=%#NotModified#%{&modified?'':'●'}
set statusline+=%#Separator#

set statusline+=\ %=
set statusline+=\ %#Separator#%#Contents#%l,%c%#Separator#
set statusline+=\ %#Separator#%#Contents#%p%%%#Separator#
set statusline+=\ %#Separator#%#Contents#%Y%#Separator#
set statusline+=\ 

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

nmap <silent> <CR> :nohlsearch<CR>
nmap <Space> <Leader>

let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_custom_colors = v:true
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
nnoremap <silent> <C-s>    :BufferPick<CR>

nmap <Leader>f :GFiles<CR>
nmap <leader>/ :BLines<CR>
nmap <Leader>\ :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>r :Rg |
nmap <leader>c :Commands<CR>

command! CopyBufferDir let  @+ = expand('%:p:h')
command! CopyBufferPath let @+ = expand('%:p')
command! CopyBufferFilename let @+ = expand('%:p:t')

augroup Ruby
  autocmd FileType ruby abbreviate <buffer> pry require 'pry'; binding.pry
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
augroup END


" Toggle Tabline
"nnoremap <silent> <C-F2> :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
"
"
" floating tooltip that lists diagnostics
"lua vim.lsp.diagnostic.show_line_diagnostics()
"


" LSP Things

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    use_lsp_diagnostic_signs = true
  }
EOF

let g:indent_blankline_char = "│"


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

lua <<EOF
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    },
})
EOF

let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_highlight_opened_files = 1
nnoremap <C-n> :NvimTreeToggle<CR>



" LSP things for style
lua <<EOF
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
EOF

" -- LspDiagnostics ---

" -- error / warnings
" fg("LspDiagnosticsSignError", red)
" fg("LspDiagnosticsVirtualTextError", red)
" fg("LspDiagnosticsSignWarning", yellow)
" fg("LspDiagnosticsVirtualTextWarning", yellow)

" -- info
" fg("LspDiagnosticsSignInformation", green)
" fg("LspDiagnosticsVirtualTextInformation", green)

" -- hint
" fg("LspDiagnosticsSignHint", purple)
" fg("LspDiagnosticsVirtualTextHint", purple)
