{ ... }:
{
  home = {
    username = "jadenmaxwell";
    homeDirectory = "/Users/jadenmaxwell";
  };

  imports = [
    ./shared.nix
    ./neovim.nix
    ./emacs.nix
    ./zsh.nix
  ];
}
