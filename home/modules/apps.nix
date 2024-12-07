{pkgs, ... }: {
    home.packages = with pkgs; [
      vlc
      zoom-us
      discord
      shotcut
      libreoffice
    ];
}
