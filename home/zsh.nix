{ inputs, config, pkgs, ... }: {

  home.packages = with pkgs; [
    meslo-lgs-nf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 100000000;

    shellAliases = {
      cd = "z";
      ls = "eza";
      update-darwin = "darwin-rebuild switch --flake ~/dotfiles";
      update-config = "sudo nixos-rebuild switch --flake ~/dotfiles";
      update-home = "home-manager switch --flake ~/dotfiles";
      update-all = "update-config && update-home";
    };

    initExtraBeforeCompInit = ''
    [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
    '';

    initExtra = ''
    export PATH=$PATH:~/.cargo/bin
    function ..      { cd .. }
    function ...     { cd ../.. }
    function ....    { cd ../../.. }
    function .....   { cd ../../../../.. }
    function ......  { cd ../../../../../.. }
    function ....... { cd ../../../../../../.. }
    '';

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
