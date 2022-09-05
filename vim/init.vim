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
set colorcolumn=80
set signcolumn=yes

" Remove arrow keys to train my fingers
noremap <Up>   <Nop>
noremap <Down>   <Nop>
noremap <Left>   <Nop>
noremap <Right>   <Nop>

" set <leader> to space
nnoremap <space> <nop>
let mapleader=" "

call plug#begin('~/.vim/plugged')
" Syntax highlighting and autocomplete for nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF for better file jumping.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Theme and Syntax Highlighting
Plug 'morhetz/gruvbox'
Plug 's3rvac/vim-syntax-yara'
call plug#end()

" Set colorscheme
let g:gruvbox_contrast_dark = 'hard'

" Transparent background with gruvbox theme
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" Yara syntax highlighting
autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara

" FZF key bindings 
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fb <cmd>Buffers<cr>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
