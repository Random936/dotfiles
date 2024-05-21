{ inputs, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    feh
    clang
    cargo
    neofetch
    #microsoft-edge
    #nextcloud-client
    #bitwarden-cli
    #bitwarden
    #discord

    # Emacs
    cmake
    isync
    ispell
    mu

    # fonts
    fira-code
    fira-code-symbols
    meslo-lgs-nf
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
    ".mbsyncrc".source = ../dotfiles/.mbsyncrc;
    ".functions.zsh".source = ../dotfiles/.functions.zsh;

    # Emacs files
    ".emacs".source = ../dotfiles/.emacs;
    ".emacs.d/config.org".source = ../dotfiles/.emacs.d/config.org;
    ".emacs.d/terminal.org".source = ../dotfiles/.emacs.d/terminal.org;
    ".emacs.d/functions.org".source = ../dotfiles/.emacs.d/functions.org;
    ".emacs.d/email.org".source = ../dotfiles/.emacs.d/email.org;
    ".emacs.d/org.org".source = ../dotfiles/.emacs.d/org.org;
    ".emacs.d/lsp.org".source = ../dotfiles/.emacs.d/lsp.org;
  };
}
