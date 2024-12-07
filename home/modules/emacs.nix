{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Build deps
    cmake
    libtool

    # Additional packages for functionality
    isync
    ispell
    texliveFull
    ledger
    mu
    zip
    unzip

    # Fonts
    maple-mono

    # LSP Servers
    nil
    ccls
    rust-analyzer
    yaml-language-server
    python3Packages.python-lsp-server
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
  ];

  programs = {
    # For integration with shell.nix files
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs29;
      extraPackages = epkgs: with epkgs; [
        mu4e
        vterm
        all-the-icons
        nerd-icons
      ];
    };
  };

  home.file = {
    ".emacs".source = ../../dotfiles/.emacs;
    ".emacs.d/config.org".source = ../../dotfiles/.emacs.d/config.org;
    ".emacs.d/terminal.org".source = ../../dotfiles/.emacs.d/terminal.org;
    ".emacs.d/functions.org".source = ../../dotfiles/.emacs.d/functions.org;
    ".emacs.d/email.org".source = ../../dotfiles/.emacs.d/email.org;
    ".emacs.d/org.org".source = ../../dotfiles/.emacs.d/org.org;
    ".emacs.d/lsp.org".source = ../../dotfiles/.emacs.d/lsp.org;
    ".mbsyncrc".source = ../../dotfiles/.mbsyncrc;
  };
}
