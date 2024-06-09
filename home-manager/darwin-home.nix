{ inputs, lib, config, pkgs, ... }:
let
  mypkgs = import ../packages/all-packages.nix {
    inherit pkgs lib config;
  };
in
{

  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  imports = [
    ./common.nix
    ./emacs.nix
    ./zsh.nix
  ];

  home.file.".tmux/plugins/tpm".source = "${mypkgs.tpm}";
}
