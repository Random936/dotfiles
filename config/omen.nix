{ ... }: {

  imports = [
    ../hardware/omen.nix
    ./headful.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Supported Filesystems
  boot.supportedFilesystems = [ "ntfs" ];

  # Set hostname
  networking.hostName = "randomctf";

  # Create user
  users.users.random = import ./user.nix;

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

  # Install OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Ignore laptop lid closing when connected to power.
  services.logind.lidSwitchExternalPower = "ignore";

  # Enable VMWare Workstation
  virtualisation.vmware.host.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
