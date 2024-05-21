{ inputs, config, pkgs, ... }: {

  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  imports = [
    ./common.nix
    ./emacs.nix
    ./zsh.nix
  ];

  home.stateVersion = "23.11";
}
