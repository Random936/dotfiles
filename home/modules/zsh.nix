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
      json-less = "jq -C . | less -R";
      csv2json = "python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))'";

      # Server user/address aliases
      r330-idrac = "bw-ssh iDRAC root@192.168.100.11 racadm";
      r730xd-idrac = "bw-ssh iDRAC root@192.168.100.12 racadm";
      ideapad = "ssh root@192.168.100.20";
      r330-proxmox = "ssh root@192.168.100.21";
      r730xd-proxmox = "ssh root@192.168.100.22";
      r330-media = "ssh media@192.168.100.40";

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
    function bw-ssh { sshpass -p "$(bw-load && bw get password "$1")" ssh ''${@:2} }

    if [[ "$(uname)" == "Darwin" ]]; then
        source <(/opt/homebrew/bin/brew shellenv)
    fi
    '';

    plugins = [
      {
        name = "custom-functions";
        src = ../../dotfiles;
        file = ".functions.zsh";
      }
      {
        name = "powerlevel10k-config";
        src = ../../dotfiles;
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
