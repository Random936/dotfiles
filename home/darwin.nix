{ pkgs, ... }: {
  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  home.packages = with pkgs; [
    virt-viewer
  ];

  imports = [
    ./shared.nix
    ./neovim.nix
    ./emacs.nix
    ./zsh.nix
  ];
}
