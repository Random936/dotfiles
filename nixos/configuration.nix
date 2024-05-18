# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable experimental nix features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # General setup
  networking.hostName = "randomctf"; # Define your hostname.
  networking.networkmanager.enable = true;
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

  # Enable Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    # Power management is experimental and known to cause issues.
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Don't use open source kernel.
    nvidiaSettings = true;
  };

  # Fix issue with Nvidia display scaling.
  services.xserver.dpi = 96;
  environment.variables.GDK_SCALE = "0.5";

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
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    picom
    cmake
    emacsPackages.vterm
    emacsPackages.mu4e
  ];
  system.stateVersion = "23.11";

}
