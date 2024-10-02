{ pkgs, ... }: {

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
      awkuniq = "sort | uniq";
      histogram = "awkuniq -c | sort -nr";
      json-less = "jq -C . | less -M";
      csv2json = "python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))'";

      # Nix Specific aliases
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
    function bw-copy { bw-load && bw get password "$1" | xsel --clipboard -i }
    function bw-clear { echo -n "" | xsel --clipboard }

    if [[ "$(uname)" == "Darwin" ]]; then
       source <(/opt/homebrew/bin/brew shellenv)
    fi
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
