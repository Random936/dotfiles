{ inputs, config, pkgs, ... }: {
  home = {
    username = "random";
    homeDirectory = "/home/random";
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    feh
    clang
    cargo
    neofetch
    microsoft-edge
    nextcloud-client
    bitwarden-cli
    bitwarden
    discord
    isync
    emacsPackages.all-the-icons-nerd-fonts
  ];

  home.file = {
    ".scripts".source = ../dotfiles/.scripts;
    ".mbsyncrc".source = ../dotfiles/.mbsyncrc;
    ".Xresources".source = ../dotfiles/.Xresources;
    ".screenlayout".source = ../dotfiles/.screenlayout;
    ".config/i3/config".source = ../dotfiles/.config/i3/config;
    ".local/share/fonts".source = ../dotfiles/.local/share/fonts;
    ".config/rofi/config.rasi".source = ../dotfiles/.config/rofi/config.rasi;
    ".config/polybar/config.ini".source = ../dotfiles/.config/polybar/config.ini;

    # Emacs files
    ".emacs".source = ../dotfiles/.emacs;
    ".emacs.d/config.org".source = ../dotfiles/.emacs.d/config.org;
    ".emacs.d/terminal.org".source = ../dotfiles/.emacs.d/terminal.org;
    ".emacs.d/functions.org".source = ../dotfiles/.emacs.d/functions.org;
    ".emacs.d/email.org".source = ../dotfiles/.emacs.d/email.org;
    ".emacs.d/org.org".source = ../dotfiles/.emacs.d/org.org;
    ".emacs.d/lsp.org".source = ../dotfiles/.emacs.d/lsp.org;
  };

  programs = {
    home-manager.enable = true;
    emacs.enable = true;
    zoxide.enable = true;
    eza.enable = true;
    fzf.enable = true;
    command-not-found.enable = true;

    git = {
      enable = true;
      userName = "Random936";
      userEmail = "randomdude936@gmail.com";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        update-system = "sudo nixos-rebuild switch --flake ~/dotfiles";
        update-user = "home-manager switch --flake ~/dotfiles";
        update-all = "update-system && update-user";
      };

      plugins = [
        {
          name = "powerlevel10k-config";
          src = ../dotfiles;
          file = ".p10k.zsh";
        }
      ];

      zplug = {
        enable = true;
        plugins = [
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };

    };
  };

  home.stateVersion = "23.05";
}
