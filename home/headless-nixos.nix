{ inputs, config, pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    ./shared.nix
    ./emacs.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [];
}
