{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    coc =  {
      enable = true;
      settings = {
        "diagnostic.checkCurrentLine" = true;
      };
    };

    plugins = with pkgs.vimPlugins; [
      supertab
      nvim-fzf
      vim-airline

      # COC packages.
      coc-sh
      coc-css
      coc-html
      coc-json
      coc-yaml
      coc-svelte
      coc-clangd
      coc-docker
      coc-tsserver
      coc-rust-analyzer
    ];

    extraConfig = ''
    " Better smart indenting.
    set formatoptions-=cro
    set tabstop=4 softtabstop=4
    set shiftwidth=4
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

    " FZF key bindings
    nnoremap <leader>pf <cmd>Files<cr>
    nnoremap <leader>pg <cmd>Rg<cr>

    " Supertab start at top of completion list
    let g:SuperTabContextDefaultCompletionType = "<c-n>"
    '';
  };
}
