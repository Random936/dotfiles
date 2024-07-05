{ config, pkgs, inputs, ... }: {

  imports = [ ./shared.nix ];

  # Networking
  networking.wireless.iwd.enable = true;
  networking.networkmanager =  {
    enable = true;
    wifi.backend = "iwd";
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system and i3 window manager.
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    # Setup i3 window manager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi
        polybar
        rxvt-unicode
        arandr
      ];
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };

  # List packages to be installed for headful systems
  environment.systemPackages = with pkgs; [
    picom
  ];

  # Install additional programs
  programs.thunar.enable = true;

}
