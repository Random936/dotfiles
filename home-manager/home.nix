{ inputs, config, pkgs, ... }: {
  home = {
    username = "random";
    homeDirectory = "/home/random";
  };

  home.packages = with pkgs; [
    meslo-lgs-nf
  ];

  home.file.".p10k.zsh".source = ../dotfiles/.p10k.zsh;

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
