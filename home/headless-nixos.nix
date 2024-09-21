{ pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    ./shared.nix
    ./neovim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    nvtopPackages.full
  ];
}
