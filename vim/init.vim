" Smart indent and and better tab length
set formatoptions-=cro
set tabstop=3 softtabstop=3
set shiftwidth=3
set expandtab
set smartindent

set nu
set relativenumber
set nohlsearch
set hidden
set incsearch
set scrolloff=8
set signcolumn=yes

" Remove arrow keys to train my fingers
noremap <Up>   <Nop>
noremap <Down>   <Nop>
noremap <Left>   <Nop>
noremap <Right>   <Nop>

" Set <leader> to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Add key bindings for fuzzy finder
nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <leader>pg <cmd>Telescope live_grep<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>ph <cmd>Telescope help_tags<cr>

call plug#begin('~/.vim/plugged')
" Syntax correcting and autocomplete for nvim
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Nvim fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Gruvbox colorscheme
Plug 'morhetz/gruvbox'
call plug#end()

" Load the clangd server as the interpreter
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}

" Set colorscheme
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
