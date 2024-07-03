{ config, pkgs, inputs, ... }:

{
  # Enable experimental nix features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.wireless.iwd.enable = true;
  networking.networkmanager =  {
    enable = true;
    wifi.backend = "iwd";
  };

  # General setup
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system and i3 window manager.
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
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
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with 
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Change default shell to zsh.
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.random = {
    isNormalUser = true;
    useDefaultShell = true;
    description = "random";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    git
    picom
    killall
  ];

  # Install additional programs
  programs.thunar.enable = true;

  # Enable services.
  services.openssh.enable = true;
  services.tailscale.enable = true;

  # Enable docker service.
  virtualisation.docker.enable = true;

  system.stateVersion = "24.05";
}
