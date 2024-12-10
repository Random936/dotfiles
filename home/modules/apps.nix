{pkgs, ... }: {
    home.packages = with pkgs; [
      vlc
      typora
      zoom-us
      discord
      libreoffice
      bitwarden-desktop
    ];
}
