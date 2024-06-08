{ inputs, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Utilities
    tmux
    btop
    manix
    p7zip
    ripgrep
    neofetch
    bitwarden-cli

    # Dev tools
    clang
    cargo
    python3
    gnumake

    # Hacking
    nmap
    john
    ffuf
    nikto
    sqlmap
    wpscan
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
}
