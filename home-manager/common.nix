{ inputs, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Nix specific utilities
    manix
    nix-tree

    # Utilities
    jq
    tmux
    ncdu
    btop
    p7zip
    ripgrep
    fastfetch
    bitwarden-cli
    openvpn

    # Dev tools
    clang
    clang-tools
    cargo
    python3
    gnumake

    # Hacking
    yara
    nmap
    john
    ffuf
    nikto
    sqlmap
    thc-hydra
    exploitdb
    feroxbuster
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
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
  };

  home.stateVersion = "24.05";
}
