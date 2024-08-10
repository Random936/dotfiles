{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Build deps
    cmake

    # Additional packages for functionality
    isync
    ispell
    ledger
    mu

    # Fonts
    iosevka

    # LSP Servers
    nil
    ccls
    rust-analyzer
    yaml-language-server
    python3Packages.python-lsp-server
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: with epkgs; [
      mu4e
      vterm
      all-the-icons
      nerd-icons
    ];
  };

  home.file = {
    ".emacs".source = ../dotfiles/.emacs;
    ".emacs.d/config.org".source = ../dotfiles/.emacs.d/config.org;
    ".emacs.d/terminal.org".source = ../dotfiles/.emacs.d/terminal.org;
    ".emacs.d/functions.org".source = ../dotfiles/.emacs.d/functions.org;
    ".emacs.d/email.org".source = ../dotfiles/.emacs.d/email.org;
    ".emacs.d/org.org".source = ../dotfiles/.emacs.d/org.org;
    ".emacs.d/lsp.org".source = ../dotfiles/.emacs.d/lsp.org;
    ".mbsyncrc".source = ../dotfiles/.mbsyncrc;
  };
}
