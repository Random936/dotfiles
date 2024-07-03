# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ../hardware/omen.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set hostname
  networking.hostName = "randomctf";

  # Enable Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    # Power management is experimental and known to cause issues.
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Don't use open source kernel.
    nvidiaSettings = true;

    prime = {

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Fix issue with Nvidia display scaling.
  services.xserver.dpi = 96;
  environment.variables.GDK_SCALE = "0.5";

  # Enable VMWare Workstation
  virtualisation.vmware.host.enable = true;

  system.stateVersion = "24.05";
}
