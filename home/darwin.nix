{ pkgs, ... }: {
  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  home.packages = with pkgs; [
    gnupg
  ];

  imports = [
    ./shared.nix
    ./modules/sketchybar.nix
    ./modules/aerospace.nix
    ./modules/neovim.nix
    ./modules/emacs.nix
    ./modules/zsh.nix
  ];

  home.file.".config/ghostty/config".source = ../dotfiles/.config/ghostty/config;
}
