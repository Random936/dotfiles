{ lib, config, pkgs, ... }:
let
  mypkgs = import ../packages/all-packages.nix {
    inherit pkgs lib config;
  };
in {

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Nix specific utilities
    manix
    nix-tree

    # Utilities
    jq
    bc
    dig
    file
    wget
    curl
    tmux
    btop
    iftop
    p7zip
    sshpass
    ripgrep
    openvpn
    pciutils
    fastfetch

    # Dev tools
    clang
    clang-tools
    cargo
    python3
    gnumake
    ansible
  ];

  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    eza.enable = true;
    fzf.enable = true;

    git = {
      enable = true;
      userName = "Random936";
      userEmail = "randomdude936@gmail.com";
    };
  };

  home.file = {
    ".functions.zsh".source = ../dotfiles/.functions.zsh;
    ".tmux/plugins/tpm".source = "${mypkgs.tpm}";
    ".tmux.conf".source = ../dotfiles/.tmux.conf;
  };

  home.stateVersion = "24.05";
}
