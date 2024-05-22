{ inputs, config, pkgs, ... }: {

  home = {
    username = "random";
    homeDirectory = "/home/random";
  };

  imports = [
    ./common.nix
    ./emacs.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    feh
    microsoft-edge
    nextcloud-client
    bitwarden
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };

  home.file = {
    ".Xresources".source = ../dotfiles/.Xresources;
    ".scripts/brightness.sh".source = ../dotfiles/.scripts/brightness.sh;
    ".scripts/autostart_desktop.sh".source = ../dotfiles/.scripts/autostart_desktop.sh;
    ".screenlayout/launch.sh".source = ../dotfiles/.screenlayout/launch.sh;
    ".screenlayout/wallpapers.sh".source = ../dotfiles/.screenlayout/wallpapers.sh;
    ".config/i3/config".source = ../dotfiles/.config/i3/config;
    ".config/rofi/config.rasi".source = ../dotfiles/.config/rofi/config.rasi;
    ".config/polybar/config.ini".source = ../dotfiles/.config/polybar/config.ini;

  };


  home.stateVersion = "23.11";
}
