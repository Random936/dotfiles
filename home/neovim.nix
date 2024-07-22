{ inputs, config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  home.file = {
    ".config/nvim/init.vim".source = ../dotfiles/.config/nvim/init.vim;
    ".config/nvim/coc-settings.json".source = ../dotfiles/.config/nvim/init.vim;
  };
}
