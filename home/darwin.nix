{ pkgs, lib, config, ... }:
let
  mypkgs = import ../packages/all-packages.nix {
    inherit pkgs lib config;
  };
in {
  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  home.packages = with mypkgs; [
    bitwarden-cli-bin
  ];

  imports = [
    ./shared.nix
    ./neovim.nix
    ./emacs.nix
    ./zsh.nix
  ];
}
