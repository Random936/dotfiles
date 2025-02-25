{ lib, ... }: {

  imports = [
    ../hardware/omen.nix
    ./headful.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Supported Filesystems
  boot.supportedFilesystems = [ "ntfs" "nfs" ];

  # Import default user config
  users.users.random = import ./user.nix;

  # Networking
  networking.hostName = "randomctf";
  networking.nameservers = [ "192.168.100.1" "8.8.8.8" "8.8.4.4" ];
  networking.firewall.allowedTCPPorts = [ 22 24800 ];

  # Temporary fix for service failure.
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

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

  # Ignore laptop lid closing when connected to power.
  services.logind.lidSwitchExternalPower = "ignore";

  # Enable VMWare Workstation
  virtualisation.vmware.host.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
