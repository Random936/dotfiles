{ inputs, config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    history.size = 100000000;

    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/dotfiles";
      update-user = "home-manager switch --flake ~/dotfiles";
      update-all = "update-system && update-user";
    };

    plugins = [
      {
        name = "custom-functions";
        src = ../dotfiles;
        file = ".functions.zsh";
      }
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
}
