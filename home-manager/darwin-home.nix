{ inputs, config, pkgs, ... }: {

  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  imports = [
    ./common.nix
    ./zsh.nix
  ];

  programs.emacs.package = pkgs.emacs-macport;

  home.stateVersion = "23.11";
}
