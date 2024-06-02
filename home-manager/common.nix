{ inputs, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    btop
    tmux
    manix
    clang
    cargo
    ripgrep
    gnumake
    neofetch
    spotify
    bitwarden-cli
  ]);

  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    eza.enable = true;
    fzf.enable = true;

    git = {
      enable = true;
      userName = "Random936";
      userEmail = "randomdude936@gmail.com";
    };
  };


  home.file = {
    ".functions.zsh".source = ../dotfiles/.functions.zsh;
  };
}
