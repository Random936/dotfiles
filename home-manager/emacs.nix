{ inputs, config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      mu4e
      vterm
      all-the-icons
      nerd-icons
    ];
  };
}
