{ pkgs, ... }: {
  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  home.packages = with pkgs; [
    virt-viewer
  ];

  imports = [
    ./shared.nix
    ./modules/sketchybar.nix
    ./modules/aerospace.nix
    ./modules/neovim.nix
    ./modules/emacs.nix
    ./modules/zsh.nix
  ];
}
