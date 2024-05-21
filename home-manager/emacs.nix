{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    cmake
    isync
    ispell
    ledger
    mu

    fira-code
    fira-code-symbols
  ];

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
