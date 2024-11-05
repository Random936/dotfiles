{ pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    ./shared.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
  ];

  home.packages = with pkgs; [
    ncdu
    nvtopPackages.full
  ];
}
