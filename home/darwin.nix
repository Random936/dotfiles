{ inputs, config, pkgs, ... }:
{

  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  imports = [
    ./shared.nix
    ./emacs.nix
    ./zsh.nix
  ];
}
