{ inputs, config, pkgs, ... }: {
  home = {
    username = "random";
    homeDirectory = "/home/random";
  };

  home.packages = with pkgs; [
    meslo-lgs-nf
    neofetch
  ];

  programs = {
    home-manager.enable = true;
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
      };

      plugins = [
        { name = "powerlevel10k-config"; src = ../dotfiles; file = ".p10k.zsh"; }
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
