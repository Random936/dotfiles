{ inputs, config, pkgs, ... }: {
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
      vim-airline
    ];
  };
}
